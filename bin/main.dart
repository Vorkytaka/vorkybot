import 'dart:io';

import 'di/dependency_injection.dart';
import 'initialize_sqlite.dart';

Future<void> main(List<String> arguments) async {
  try {
    // Initialize SQLite for platform-specific handling
    initializeSqlite();
    // Get the DI container instance
    final di = VorkyBotDi.instance;
    
    // Get the bot instance (this will initialize the entire dependency tree)
    final bot = di.bot;
    
    // Initialize the bot (get username, etc.)
    await bot.initialize();

    // Start the bot
    bot.start();

    // Register process signal handlers for clean shutdown
    ProcessSignal.sigint.watch().listen((signal) {
      di.logger.log('TerminationSignal', {'action': 'shutdown'});
      bot.stop();
      exit(0);
    });
  } catch (e, st) {
    VorkyBotDi.instance.logger.log('StartupError', {
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
