import 'package:drift/drift.dart';

class PUsers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().nullable().unique()();
  TextColumn get name => text().customConstraint('NOT NULL')();
}

class PChats extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastPlayDate => dateTime().nullable()();
  IntColumn get lastWinnerId => integer().nullable()();
  BoolColumn get autoplay => boolean().withDefault(const Constant(false))();
}

class PUserChats extends Table {
  IntColumn get userId =>
      integer().customConstraint('REFERENCES p_users(id) NOT NULL')();
  IntColumn get chatId =>
      integer().customConstraint('REFERENCES p_chats(id) NOT NULL')();
  IntColumn get wins => integer().withDefault(const Constant(0))();
  TextColumn get callMe => text().nullable()();

  @override
  Set<Column> get primaryKey => {userId, chatId};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {userId, chatId, callMe},
      ];
}
