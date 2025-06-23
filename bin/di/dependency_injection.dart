import 'dart:io';

import '../config/config.dart';
import '../models/prediction_provider.dart';
import '../models/file_prediction_provider.dart';
import '../models/in_memory_prediction_provider.dart';
import '../models/predictions.dart';
import '../services/cooldown_manager.dart';
import '../services/logger.dart';
import '../bot/handlers/future_command_handler.dart';
import '../bot/handlers/pgame_command_handler.dart';
import '../bot/vorky_bot.dart';
import '../database/database.dart';
import '../pgame/drift_pgame_repository.dart';
import '../pgame/pgame.dart';
import 'dependency_interface.dart';

final class VorkyBotDi implements DependencyContainer {
  // Singleton pattern
  static VorkyBotDi? _instance;
  static VorkyBotDi get instance => _instance ??= VorkyBotDi._();

  // Private constructor
  VorkyBotDi._();

  // Instance fields for lazy initialization
  BotConfig? _config;
  Logger? _logger;
  PredictionProvider? _predictionProvider;
  CooldownManager? _cooldownManager;
  FutureCommandHandler? _futureCommandHandler;
  PDatabase? _pgameDatabase;
  DriftPGameRepository? _pgameRepository;
  PGame? _pgame;
  PGameCommandHandler? _pgameCommandHandler;
  VorkyBot? _bot;

  // Configuration
  @override
  BotConfig get config {
    return _config ??= BotConfig.init();
  }

  // Services
  @override
  Logger get logger {
    return _logger ??= Logger.instance;
  }

  @override
  PredictionProvider get predictionProvider {
    if (_predictionProvider != null) return _predictionProvider!;

    const predictionsFilePath = '/app/data/predictions.txt';
    final predictionsFile = File(predictionsFilePath);

    if (predictionsFile.existsSync()) {
      logger.log(
          'PredictionSource', {'source': 'file', 'path': predictionsFilePath});
      _predictionProvider = FilePredictionProvider(predictionsFilePath);
    } else {
      logger.log('PredictionSource',
          {'source': 'in-memory', 'count': defaultPredictions.length});
      _predictionProvider = InMemoryPredictionProvider(defaultPredictions);
    }

    return _predictionProvider!;
  }

  @override
  CooldownManager get cooldownManager {
    return _cooldownManager ??= CooldownManager(
      cooldownDuration: config.cooldownDuration,
    );
  }

  // Handlers
  @override
  FutureCommandHandler get futureCommandHandler {
    return _futureCommandHandler ??= FutureCommandHandler(
      prediction: predictionProvider,
      cooldownManager: cooldownManager,
    );
  }

  // PGame dependencies
  @override
  PDatabase get pgameDatabase {
    return _pgameDatabase ??= PDatabase();
  }

  @override
  DriftPGameRepository get pgameRepository {
    return _pgameRepository ??= DriftPGameRepository(pgameDatabase);
  }

  @override
  PGame get pgame {
    return _pgame ??= PGame(repository: pgameRepository);
  }

  @override
  PGameCommandHandler get pgameCommandHandler {
    return _pgameCommandHandler ??= PGameCommandHandler(
      pgame: pgame,
      repository: pgameRepository,
    );
  }

  // Main bot instance
  @override
  VorkyBot get bot {
    return _bot ??= VorkyBot(
      apiKey: config.apiKey,
      futureCommandHandler: futureCommandHandler,
      pgameCommandHandler: pgameCommandHandler,
    );
  }

  // Utility methods for testing or resetting state
  @override
  void reset() {
    _config = null;
    _logger = null;
    _predictionProvider = null;
    _cooldownManager = null;
    _futureCommandHandler = null;
    _pgameDatabase = null;
    _pgameRepository = null;
    _pgame = null;
    _pgameCommandHandler = null;
    _bot = null;
  }

  // For dependency injection override (useful for testing)
  @override
  void overridePredictionProvider(PredictionProvider provider) {
    _predictionProvider = provider;
  }

  @override
  void overrideCooldownManager(CooldownManager manager) {
    _cooldownManager = manager;
  }
}
