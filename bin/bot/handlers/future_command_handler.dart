import 'package:teledart/model.dart';
import '../../models/prediction_provider.dart';
import '../../services/cooldown_manager.dart';
import '../../utils/plural.dart';

/// Handles the /future command logic for the bot
class FutureCommandHandler {
  final PredictionProvider _prediction;
  final CooldownManager _cooldownManager;

  FutureCommandHandler({
    required PredictionProvider prediction,
    required CooldownManager cooldownManager,
  })  : _prediction = prediction,
        _cooldownManager = cooldownManager;

  Future<void> handle(TeleDartMessage message) async {
    final userId = message.from?.id;

    if (userId == null) {
      message.reply(
        'Ошибка: Не могу идентифицировать пользователя.',
        withQuote: true,
      );
      return;
    }

    // Check if user is on cooldown
    final remainingCooldown = _cooldownManager.getRemainingCooldown(userId);
    if (remainingCooldown != null) {
      final formattedTime = _formatRemainingTime(remainingCooldown);
      message.reply(
        'Нужно подождать $formattedTime прежде чем спрашивать новое предсказание.',
        withQuote: true,
      );
      return;
    }

    // User is not on cooldown, provide a prediction
    final randomPrediction = await _prediction.getRandomPrediction();

    // Update the last prediction time for this user
    _cooldownManager.recordPrediction(userId);

    // Reply with the prediction
    await message.reply(
      randomPrediction,
      withQuote: true,
    );
  }

  /// Formats a duration into a human-readable string (hours and minutes) in Russian
  static String _formatRemainingTime(Duration duration) {
    if (duration.inHours > 0) {
      final hours = duration.inHours;
      final hourForm = getRussianPluralForm(hours, 'час', 'часа', 'часов');
      return '$hours $hourForm';
    } else if (duration.inMinutes > 0) {
      final minutes = duration.inMinutes;
      final minuteForm =
          getRussianPluralForm(minutes, 'минуту', 'минуты', 'минут');
      return '$minutes $minuteForm';
    } else {
      final seconds = duration.inSeconds;
      final secondForm =
          getRussianPluralForm(seconds, 'секунду', 'секунды', 'секунд');
      return '$seconds $secondForm';
    }
  }
}
