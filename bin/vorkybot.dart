import 'dart:io';

import 'bot/handlers/handlers.dart';
import 'bot/vorky_bot.dart';
import 'models/file_prediction_provider.dart';
import 'models/in_memory_prediction_provider.dart';
import 'models/prediction_provider.dart';
import 'models/predictions.dart';
import 'pgame/database/database.dart';
import 'pgame/drift_pgame_repository.dart';
import 'pgame/pgame.dart';
import 'services/cooldown_manager.dart';
import 'services/logger.dart';

Future<void> main(List<String> arguments) async {
  // Get API key from environment variable (primary source)
  String? apiKey = Platform.environment['API_KEY'];

  // If not found in environment, try to read from local file (fallback)
  if (apiKey == null || apiKey.isEmpty) {
    final apiKeyFile = File('api_key.txt');
    if (await apiKeyFile.exists()) {
      try {
        apiKey = (await apiKeyFile.readAsString()).trim();
        Logger.instance.log('ApiKeySource', {'source': 'api_key.txt'});
      } catch (e) {
        Logger.instance.log('ApiKeyError', {
          'error': 'Failed to read API key from file',
          'details': e.toString()
        });
      }
    }
  }

  // Exit if API key is still not available
  if (apiKey == null || apiKey.isEmpty) {
    Logger.instance.log('CriticalError', {
      'error': 'API_KEY not found',
      'message':
          'Please either:\n  1. Set the API_KEY environment variable, or\n  2. Create an api_key.txt file in the project root with your Telegram Bot API token'
    });
    exit(1);
  }

  final cooldownDuration = run(() {
    final str = Platform.environment['COOLDOWN_DURATION_SEC'] ?? '60';
    final integer = int.tryParse(str);
    return integer != null ? Duration(seconds: integer) : null;
  });

  // Set up our dependencies
  // Only use Docker predictions file path
  const predictionsFilePath = '/app/data/predictions.txt';
  final PredictionProvider prediction;
  final predictionsFile = File(predictionsFilePath);
  if (predictionsFile.existsSync()) {
    // Use file-based predictions if the file exists and is not empty
    Logger.instance.log(
        'PredictionSource', {'source': 'file', 'path': predictionsFilePath});
    prediction = FilePredictionProvider(predictionsFilePath);
  } else {
    // Fall back to in-memory predictions if the file doesn't exist or is empty
    Logger.instance.log('PredictionSource',
        {'source': 'in-memory', 'count': defaultPredictions.length});
    prediction = InMemoryPredictionProvider(defaultPredictions);
  }

  final cooldownManager = CooldownManager(
    cooldownDuration: cooldownDuration ?? Duration(days: 1),
  );

  final futureCommandHandler = FutureCommandHandler(
    prediction: prediction,
    cooldownManager: cooldownManager,
  );

  // --- PGame dependencies ---
  final pgameDb = PDatabase();
  final pgameRepository = DriftPGameRepository(pgameDb);
  final pgame = PGame(repository: pgameRepository);
  final pgameCommandHandler = PGameCommandHandler(pgame: pgame);
  // --- end PGame dependencies ---

  // Create and start the bot
  final bot = VorkyBot(
    apiKey: apiKey,
    futureCommandHandler: futureCommandHandler,
    pgameCommandHandler: pgameCommandHandler,
  );

  try {
    // Initialize the bot (get username, etc.)
    await bot.initialize();

    // Start the bot
    bot.start();

    // Register process signal handlers for clean shutdown
    ProcessSignal.sigint.watch().listen((signal) {
      Logger.instance.log('TerminationSignal', {'action': 'shutdown'});
      bot.stop();
      exit(0);
    });
  } catch (e, st) {
    Logger.instance.log('StartupError', {
      'error': 'Failed to start bot',
      'exception': e.toString(),
      'stackTrace': st.toString()
    });
    exit(1);
  }
}

@pragma('vm:prefer-inline')
T run<T>(T Function() fn) {
  return fn();
}
