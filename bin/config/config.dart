import 'dart:io';

import '../services/logger.dart';

final class BotConfig {
  final String apiKey;
  final Duration cooldownDuration;

  const BotConfig({
    required this.apiKey,
    required this.cooldownDuration,
  });

  /// Creates a BotConfig by reading from environment variables and files
  static BotConfig init() {
    final apiKey = _getApiKey();
    final cooldownDuration = _getCooldownDuration();

    return BotConfig(
      apiKey: apiKey,
      cooldownDuration: cooldownDuration,
    );
  }

  static String _getApiKey() {
    // Get API key from environment variable (primary source)
    String? apiKey = Platform.environment['API_KEY'];

    // If not found in environment, try to read from local file (fallback)
    if (apiKey == null || apiKey.isEmpty) {
      final apiKeyFile = File('api_key.txt');
      if (apiKeyFile.existsSync()) {
        try {
          apiKey = (apiKeyFile.readAsStringSync()).trim();
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

    return apiKey;
  }

  static Duration _getCooldownDuration() {
    final str = Platform.environment['COOLDOWN_DURATION_SEC'] ?? '60';
    final integer = int.tryParse(str);
    return integer != null ? Duration(seconds: integer) : Duration(days: 1);
  }
}
