import 'dart:math';

import 'models/models.dart';
import 'models/play_result.dart';
import 'models/registration_result.dart';
import 'pgame_repository.dart';

final class PGame {
  final PGameRepository _repository;
  final Random _random = Random();

  PGame({
    required PGameRepository repository,
  }) : _repository = repository;

  Future<RegistrationResult> register(UserEntity user, int chatId) async {
    return _repository.registerUser(user, chatId);
  }

  Future<PlayResult> play(int chatId) async {
    // Check if the game was already played today in this chat
    final lastPlayDate = await _repository.getLastPlayDate(chatId);
    final now = DateTime.now().toUtc();
    if (lastPlayDate != null &&
        lastPlayDate.year == now.year &&
        lastPlayDate.month == now.month &&
        lastPlayDate.day == now.day) {
      return PlayResult.alreadyPlayedToday;
    }

    final registeredUsers = await _repository.getRegisteredUsers(chatId);
    if (registeredUsers.isEmpty) {
      return PlayResult.noRegisteredUsers;
    }

    final randomUser = registeredUsers[_random.nextInt(registeredUsers.length)];
    await _repository.incrementWins(randomUser.id, chatId);

    return PlayResult.success;
  }
}
