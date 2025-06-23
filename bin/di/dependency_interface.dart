import '../config/config.dart';
import '../models/prediction_provider.dart';
import '../services/cooldown_manager.dart';
import '../services/logger.dart';
import '../bot/handlers/future_command_handler.dart';
import '../bot/handlers/pgame_command_handler.dart';
import '../bot/vorky_bot.dart';
import '../database/database.dart';
import '../pgame/drift_pgame_repository.dart';
import '../pgame/pgame.dart';

/// Interface for dependency injection container
abstract interface class DependencyContainer {
  // Configuration
  BotConfig get config;

  // Services
  Logger get logger;
  PredictionProvider get predictionProvider;
  CooldownManager get cooldownManager;

  // Handlers
  FutureCommandHandler get futureCommandHandler;
  PGameCommandHandler get pgameCommandHandler;

  // PGame dependencies
  PDatabase get pgameDatabase;
  DriftPGameRepository get pgameRepository;
  PGame get pgame;

  // Main bot instance
  VorkyBot get bot;

  // Lifecycle management
  void reset();

  // Testing support
  void overridePredictionProvider(PredictionProvider provider);
  void overrideCooldownManager(CooldownManager manager);
}
