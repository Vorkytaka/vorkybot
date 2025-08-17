import 'package:teledart/model.dart';

import '../../pgame/models/models.dart';
import '../../pgame/models/play_result.dart';
import '../../pgame/models/registration_result.dart';
import '../../pgame/pgame.dart';
import '../../pgame/pgame_repository.dart';
import 'responses.dart';
import '../../utils/plural.dart';

/// Handles /pgame_register and /pgame_play commands
class PGameCommandHandler {
  final PGame _pgame;
  final PGameRepository _repository;

  PGameCommandHandler({
    required PGame pgame,
    required PGameRepository repository,
  })  : _pgame = pgame,
        _repository = repository;

  Future<void> handleRegister(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        PGameResponses.groupOnly(),
        withQuote: true,
      );
      return;
    }

    final user = message.from?.toUserEntity();

    if (user == null) {
      await message.reply(
        'Ошибка: Не могу идентифицировать пользователя.',
        withQuote: true,
      );
      return;
    }

    final result = await _pgame.register(user, message.chat.id);

    switch (result) {
      case RegistrationResult.success:
        await message.reply(
          PGameResponses.registrationSuccess(),
          withQuote: true,
        );
        break;
      case RegistrationResult.alreadyRegistered:
        await message.reply(
          PGameResponses.alreadyRegistered(),
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

  Future<void> handlePlay(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        PGameResponses.groupOnly(),
        withQuote: true,
      );
      return;
    }

    final user = message.from?.toUserEntity();

    if (user == null) {
      await message.reply(
        'Ошибка: Не могу идентифицировать пользователя.',
        withQuote: true,
      );
      return;
    }

    final result = await _pgame.play(message.chat.id);

    switch (result) {
      case PlayResult.success:
        final winner = await _repository.getLastWinner(message.chat.id);
        for (final text in PGameResponses.searching(winner!.displayName)) {
          await message.reply(text);
          await Future.delayed(Duration(milliseconds: 500));
        }
        return;
      case PlayResult.alreadyPlayedToday:
        final lastWinner = await _repository.getLastWinner(message.chat.id);
        await message.reply(
          PGameResponses.alreadyPlayedToday(lastWinner?.displayName),
          withQuote: true,
        );
        return;
      case PlayResult.noRegisteredUsers:
        await message.reply(
          PGameResponses.noRegisteredUsers(),
          withQuote: true,
        );
        return;
      case PlayResult.error:
        await message.reply(
          PGameResponses.error(),
          withQuote: true,
        );
        return;
    }
  }

  Future<void> handleResults(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        PGameResponses.groupOnly(),
        withQuote: true,
      );
      return;
    }

    final results = await _repository.getResults(message.chat.id);
    if (results.isEmpty) {
      await message.reply(
        PGameResponses.noPHere(),
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

  Future<void> handlePlayers(TeleDartMessage message) async {
    if (message.chat.type != Chat.typeGroup &&
        message.chat.type != Chat.typeSuperGroup) {
      await message.reply(
        PGameResponses.groupOnly(),
        withQuote: true,
      );
      return;
    }

    final players = await _repository.getRegisteredUsers(message.chat.id);

    if (players.isEmpty) {
      await message.reply(
        PGameResponses.noPlayersRegistered(),
        withQuote: true,
      );
      return;
    }

    final buffer = StringBuffer();
    for (var i = 0; i < players.length; i++) {
      final player = players[i];
      final position = i + 1;
      buffer.writeln('$position. ${player.displayName}');
    }

    final title = PGameResponses.playersListTitle(players.length);
    final playersList = buffer.toString();

    await message.reply(
      '$title\n\n$playersList',
      withQuote: true,
    );
  }
}
