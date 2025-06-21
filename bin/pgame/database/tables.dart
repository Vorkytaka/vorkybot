import 'package:drift/drift.dart';

class PUsers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().nullable().customConstraint('UNIQUE')();
  TextColumn get name => text().customConstraint('NOT NULL')();
  TextColumn get callMe => text().nullable().customConstraint('UNIQUE')();
}

class PChats extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get lastPlayDate => dateTime().nullable()();
  IntColumn get lastWinnerId => integer().nullable()();
}

class PUserChats extends Table {
  IntColumn get userId => integer().customConstraint('REFERENCES p_users(id) NOT NULL')();
  IntColumn get chatId => integer().customConstraint('REFERENCES p_chats(id) NOT NULL')();
  IntColumn get wins => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {userId, chatId};
}
