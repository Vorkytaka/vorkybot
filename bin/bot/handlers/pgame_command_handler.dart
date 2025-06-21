import 'package:teledart/model.dart';
import '../../pgame/pgame.dart';

/// Handles /pgame_register and /pgame_play commands
class PGameCommandHandler {
  final PGame _pgame;

  PGameCommandHandler({required PGame pgame}) : _pgame = pgame;

  Future<void> handleRegister(TeleDartMessage message) async {
    await _pgame.register(message);
  }

  Future<void> handlePlay(TeleDartMessage message) async {
    await _pgame.play(message);
  }

  Future<void> handleResults(TeleDartMessage message) async {
    await _pgame.results(message);
  }
}
