import 'dart:math';

import 'package:drift/drift.dart';
import 'package:teledart/model.dart';

import '../utils/plural.dart';
import '../utils/telegram.dart';
import 'models/models.dart';

final class PGame {
  final PGameRepository _repository;
  final Random _random = Random();

  PGame({
    required PGameRepository repository,
  }) : _repository = repository;

  Future<void> register(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        'Ошибка: Эта команда доступна только в групповых чатах.',
        withQuote: true,
      );
      return;
    }

    final user = message.from;
    if (user == null) {
      await message.reply(
        'Ошибка: Не могу идентифицировать пользователя.',
        withQuote: true,
      );
      return;
    }

    final result = await _repository.registerUser(user, message.chat);

    switch (result) {
      case RegistrationResult.success:
        await message.reply(
          'Вы успешно зарегистрированы для игры в этом чате!',
          withQuote: true,
        );
        break;
      case RegistrationResult.alreadyRegistered:
        await message.reply(
          'Вы уже зарегистрированы для игры в этом чате.',
          withQuote: true,
        );
        break;
      case RegistrationResult.error:
        await message.reply(
          'Произошла ошибка при регистрации. Пожалуйста, идите нахуй.',
          withQuote: true,
        );
        break;
    }
  }

  Future<void> play(TeleDartMessage message) async {
    if (!message.isGroupChat()) {
      return;
    }

    final user = message.from;
    if (user == null) {
      await message.reply(
        'Ошибка: Не могу идентифицировать пользователя.',
        withQuote: true,
      );
      return;
    }

    // Check if the game was already played today in this chat
    final lastPlayDate = await _repository.getLastPlayDate(message.chat.id);
    final now = DateTime.now().toUtc();
    if (lastPlayDate != null &&
        lastPlayDate.year == now.year &&
        lastPlayDate.month == now.month &&
        lastPlayDate.day == now.day) {
      final lastWinner = await _repository.getLastWinner(message.chat.id);
      final buffer = StringBuffer();
      buffer.write('Сегодня пидор дня уже был найден.');
      if (lastWinner != null) {
        buffer.write(' Это был ${lastWinner.displayName}.');
      }
      buffer.write(' Попробуйте снова завтра!');
      await message.reply(
        buffer.toString(),
        withQuote: true,
      );
      return;
    }

    final registeredUsers =
        await _repository.getRegisteredUsers(message.chat.id);
    if (registeredUsers.isEmpty) {
      await message.reply(
        'Ошибка: Нет зарегистрированных пользователей для игры в этом чате.',
        withQuote: true,
      );
      return;
    }

    final randomUser = registeredUsers[_random.nextInt(registeredUsers.length)];
    await _repository.incrementWins(randomUser.id, message.chat.id);

    for (final text in [
      '📡 Активирую систему определения пидора... 📡',
      '🔍 Пидор определяется... 🔍',
      '🧑 Анализирую участников чата... 🧑‍🔬',
      '👀 Проверяю ваши переписки... 👀',
      '🏅 Пидор найден! Определенно это ${randomUser.displayName}! 🏅',
    ]) {
      await message.reply(text);
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  Future<void> results(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        'Ошибка: Эта команда доступна только в групповых чатах.',
        withQuote: true,
      );
      return;
    }

    final results = await _repository.getResults(message.chat.id);
    if (results.isEmpty) {
      await message.reply(
        'Кажется здесь нет ни одного пидора.',
        withQuote: true,
      );
      return;
    }

    final buffer = StringBuffer();
    for (var i = 0; i < results.length; i++) {
      final user = results[i].$1;
      final count = results[i].$2;
      final place = i + 1;
      buffer.writeln(
        '$place. ${user.displayName} был ПИДОРОМ $count ${getRussianPluralForm(count, 'раз', 'раза', 'раз')}',
      );
    }
    final resultList = buffer.toString();
    final title =
        'Топ ${results.length} ${getRussianPluralForm(results.length, 'ПИДОРАСА', 'ПИДОРА', 'ПИДОРОВ')} в этом чате:';
    await message.reply(
      '$title\n\n$resultList',
      withQuote: true,
    );
  }
}

enum RegistrationResult {
  success,
  alreadyRegistered,
  error,
}

abstract interface class PGameRepository {
  Future<RegistrationResult> registerUser(User user, Chat chat);

  Future<List<UserEntity>> getRegisteredUsers(int chatId);

  Future<void> incrementWins(int userId, int chatId);

  Future<List<(UserEntity, int)>> getResults(int chatId);

  /// Returns the last play date (UTC) for the given chat, or null if never played.
  Future<DateTime?> getLastPlayDate(int chatId);

  Future<UserEntity?> getLastWinner(int chatId);
}
