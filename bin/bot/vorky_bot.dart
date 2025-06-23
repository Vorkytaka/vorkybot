import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:teledart/model.dart';
import 'dart:async';

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

  /// Max age of messages to process in minutes
  static const int _maxMessageAgeMinutes = 30;

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

    _teledart
        .onCommand('future')
        .withAgeCheck()
        .listen(_futureCommandHandler.handle);
    _teledart
        .onCommand('register')
        .withAgeCheck()
        .listen(_pgameCommandHandler.handleRegister);
    _teledart
        .onCommand('play')
        .withAgeCheck()
        .listen(_pgameCommandHandler.handlePlay);
    _teledart
        .onCommand('results')
        .withAgeCheck()
        .listen(_pgameCommandHandler.handleResults);

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

extension on Stream<TeleDartMessage> {
  /// Adds a message age check to the stream
  Stream<TeleDartMessage> withAgeCheck() {
    return where(_isMessageRecentWithLogging);
  }
}

bool _isMessageRecentWithLogging(TeleDartMessage message) {
  final now = DateTime.now();
  final messageTime = DateTime.fromMillisecondsSinceEpoch(message.date * 1000);
  final difference = now.difference(messageTime);

  final recent = difference.inMinutes < VorkyBot._maxMessageAgeMinutes;

  if (!recent) {
    Logger.instance.log('MessageIgnored', {
      'reason': 'too_old',
      'messageDate': messageTime.toIso8601String(),
      'messageId': message.messageId.toString(),
      'chatId': message.chat.id.toString(),
      'userId': message.from?.id.toString() ?? 'unknown',
      'username': message.from?.username ?? 'unknown',
      'command': message.text ?? 'unknown',
      'now': now.toIso8601String(),
    });
  }
  return recent;
}
