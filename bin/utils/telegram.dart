import 'package:teledart/model.dart';

extension TeleDartMessageX on TeleDartMessage {
  bool isGroupChat() {
    if (chat.type != Chat.typeGroup && chat.type != Chat.typeSuperGroup) {
      reply(
        'Ошибка: Эта команда доступна только в групповых чатах.',
        withQuote: true,
      );
      return false;
    }
    return true;
  }
}