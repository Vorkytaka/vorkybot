import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

import '../services/logger.dart';

import 'handlers/future_command_handler.dart';
import 'handlers/pgame_command_handler.dart';

/// Main bot class that handles Telegram integration and command processing
class VorkyBot {
  /// The API key for the Telegram Bot API
  final String _apiKey;

  /// TeleDart instance for bot functionality
  late final TeleDart _teledart;

  /// Handler for the /future command
  final FutureCommandHandler _futureCommandHandler;

  /// Handler for the /pgame commands
  final PGameCommandHandler _pgameCommandHandler;

  /// Username of the bot
  String? _username;

  /// Flag indicating if the bot has been started
  bool _isStarted = false;

  /// Creates a new [VorkyBot] instance with dependencies
  VorkyBot({
    required String apiKey,
    required FutureCommandHandler futureCommandHandler,
    required PGameCommandHandler pgameCommandHandler,
  })  : _apiKey = apiKey,
        _futureCommandHandler = futureCommandHandler,
        _pgameCommandHandler = pgameCommandHandler;

  /// Gets the username of the bot
  String? get username => _username;

  /// Initialize the bot and fetch its information
  Future<void> initialize() async {
    try {
      final telegram = Telegram(_apiKey);
      final me = await telegram.getMe();
      _username = me.username;

      if (_username == null) {
        throw Exception('Failed to get bot username');
      }

      _teledart = TeleDart(_apiKey, Event(_username!));
      Logger.instance.log('BotInitialized', {'username': '@$_username'});
    } catch (e) {
      throw Exception('Failed to initialize bot: $e');
    }
  }

  /// Set up bot commands and start listening
  void start() {
    if (_username == null) {
      throw Exception('Bot not initialized. Call initialize() first');
    }

    if (_isStarted) {
      throw Exception('Bot has already been started');
    }

    // Handle /future command
    _teledart.onCommand('future').listen(_futureCommandHandler.handle);
    // Handle /pgame_register and /pgame_play commands
    _teledart.onCommand('register').listen(_pgameCommandHandler.handleRegister);
    _teledart.onCommand('play').listen(_pgameCommandHandler.handlePlay);
    // Handle /pgame_results command
    _teledart.onCommand('results').listen(_pgameCommandHandler.handleResults);

    // Start the bot
    _teledart.start();
    _isStarted = true;
    Logger.instance.log('BotStarted', {'username': '@$_username'});
  }

  /// Stop the bot
  void stop() {
    if (_isStarted) {
      _teledart.stop();
      _isStarted = false;
      Logger.instance.log('BotStopped', {'username': '@$_username'});
    }
  }
}
