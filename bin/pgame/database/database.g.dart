// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PUsersTable extends PUsers with TableInfo<$PUsersTable, PUser> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PUsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _callMeMeta = const VerificationMeta('callMe');
  @override
  late final GeneratedColumn<String> callMe = GeneratedColumn<String>(
      'call_me', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'UNIQUE');
  @override
  List<GeneratedColumn> get $columns => [id, username, name, callMe];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'p_users';
  @override
  VerificationContext validateIntegrity(Insertable<PUser> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('call_me')) {
      context.handle(_callMeMeta,
          callMe.isAcceptableOrUnknown(data['call_me']!, _callMeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PUser map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PUser(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      callMe: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}call_me']),
    );
  }

  @override
  $PUsersTable createAlias(String alias) {
    return $PUsersTable(attachedDatabase, alias);
  }
}

class PUser extends DataClass implements Insertable<PUser> {
  final int id;
  final String? username;
  final String name;
  final String? callMe;
  const PUser(
      {required this.id, this.username, required this.name, this.callMe});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || callMe != null) {
      map['call_me'] = Variable<String>(callMe);
    }
    return map;
  }

  PUsersCompanion toCompanion(bool nullToAbsent) {
    return PUsersCompanion(
      id: Value(id),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      name: Value(name),
      callMe:
          callMe == null && nullToAbsent ? const Value.absent() : Value(callMe),
    );
  }

  factory PUser.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PUser(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String?>(json['username']),
      name: serializer.fromJson<String>(json['name']),
      callMe: serializer.fromJson<String?>(json['callMe']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String?>(username),
      'name': serializer.toJson<String>(name),
      'callMe': serializer.toJson<String?>(callMe),
    };
  }

  PUser copyWith(
          {int? id,
          Value<String?> username = const Value.absent(),
          String? name,
          Value<String?> callMe = const Value.absent()}) =>
      PUser(
        id: id ?? this.id,
        username: username.present ? username.value : this.username,
        name: name ?? this.name,
        callMe: callMe.present ? callMe.value : this.callMe,
      );
  PUser copyWithCompanion(PUsersCompanion data) {
    return PUser(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      name: data.name.present ? data.name.value : this.name,
      callMe: data.callMe.present ? data.callMe.value : this.callMe,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PUser(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('callMe: $callMe')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, name, callMe);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PUser &&
          other.id == this.id &&
          other.username == this.username &&
          other.name == this.name &&
          other.callMe == this.callMe);
}

class PUsersCompanion extends UpdateCompanion<PUser> {
  final Value<int> id;
  final Value<String?> username;
  final Value<String> name;
  final Value<String?> callMe;
  const PUsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.name = const Value.absent(),
    this.callMe = const Value.absent(),
  });
  PUsersCompanion.insert({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    required String name,
    this.callMe = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PUser> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? name,
    Expression<String>? callMe,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (name != null) 'name': name,
      if (callMe != null) 'call_me': callMe,
    });
  }

  PUsersCompanion copyWith(
      {Value<int>? id,
      Value<String?>? username,
      Value<String>? name,
      Value<String?>? callMe}) {
    return PUsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      callMe: callMe ?? this.callMe,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (callMe.present) {
      map['call_me'] = Variable<String>(callMe.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PUsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('name: $name, ')
          ..write('callMe: $callMe')
          ..write(')'))
        .toString();
  }
}

class $PChatsTable extends PChats with TableInfo<$PChatsTable, PChat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lastPlayDateMeta =
      const VerificationMeta('lastPlayDate');
  @override
  late final GeneratedColumn<DateTime> lastPlayDate = GeneratedColumn<DateTime>(
      'last_play_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastWinnerIdMeta =
      const VerificationMeta('lastWinnerId');
  @override
  late final GeneratedColumn<int> lastWinnerId = GeneratedColumn<int>(
      'last_winner_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, lastPlayDate, lastWinnerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'p_chats';
  @override
  VerificationContext validateIntegrity(Insertable<PChat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_play_date')) {
      context.handle(
          _lastPlayDateMeta,
          lastPlayDate.isAcceptableOrUnknown(
              data['last_play_date']!, _lastPlayDateMeta));
    }
    if (data.containsKey('last_winner_id')) {
      context.handle(
          _lastWinnerIdMeta,
          lastWinnerId.isAcceptableOrUnknown(
              data['last_winner_id']!, _lastWinnerIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PChat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PChat(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lastPlayDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_play_date']),
      lastWinnerId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_winner_id']),
    );
  }

  @override
  $PChatsTable createAlias(String alias) {
    return $PChatsTable(attachedDatabase, alias);
  }
}

class PChat extends DataClass implements Insertable<PChat> {
  final int id;
  final DateTime? lastPlayDate;
  final int? lastWinnerId;
  const PChat({required this.id, this.lastPlayDate, this.lastWinnerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || lastPlayDate != null) {
      map['last_play_date'] = Variable<DateTime>(lastPlayDate);
    }
    if (!nullToAbsent || lastWinnerId != null) {
      map['last_winner_id'] = Variable<int>(lastWinnerId);
    }
    return map;
  }

  PChatsCompanion toCompanion(bool nullToAbsent) {
    return PChatsCompanion(
      id: Value(id),
      lastPlayDate: lastPlayDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPlayDate),
      lastWinnerId: lastWinnerId == null && nullToAbsent
          ? const Value.absent()
          : Value(lastWinnerId),
    );
  }

  factory PChat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PChat(
      id: serializer.fromJson<int>(json['id']),
      lastPlayDate: serializer.fromJson<DateTime?>(json['lastPlayDate']),
      lastWinnerId: serializer.fromJson<int?>(json['lastWinnerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastPlayDate': serializer.toJson<DateTime?>(lastPlayDate),
      'lastWinnerId': serializer.toJson<int?>(lastWinnerId),
    };
  }

  PChat copyWith(
          {int? id,
          Value<DateTime?> lastPlayDate = const Value.absent(),
          Value<int?> lastWinnerId = const Value.absent()}) =>
      PChat(
        id: id ?? this.id,
        lastPlayDate:
            lastPlayDate.present ? lastPlayDate.value : this.lastPlayDate,
        lastWinnerId:
            lastWinnerId.present ? lastWinnerId.value : this.lastWinnerId,
      );
  PChat copyWithCompanion(PChatsCompanion data) {
    return PChat(
      id: data.id.present ? data.id.value : this.id,
      lastPlayDate: data.lastPlayDate.present
          ? data.lastPlayDate.value
          : this.lastPlayDate,
      lastWinnerId: data.lastWinnerId.present
          ? data.lastWinnerId.value
          : this.lastWinnerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PChat(')
          ..write('id: $id, ')
          ..write('lastPlayDate: $lastPlayDate, ')
          ..write('lastWinnerId: $lastWinnerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastPlayDate, lastWinnerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PChat &&
          other.id == this.id &&
          other.lastPlayDate == this.lastPlayDate &&
          other.lastWinnerId == this.lastWinnerId);
}

class PChatsCompanion extends UpdateCompanion<PChat> {
  final Value<int> id;
  final Value<DateTime?> lastPlayDate;
  final Value<int?> lastWinnerId;
  const PChatsCompanion({
    this.id = const Value.absent(),
    this.lastPlayDate = const Value.absent(),
    this.lastWinnerId = const Value.absent(),
  });
  PChatsCompanion.insert({
    this.id = const Value.absent(),
    this.lastPlayDate = const Value.absent(),
    this.lastWinnerId = const Value.absent(),
  });
  static Insertable<PChat> custom({
    Expression<int>? id,
    Expression<DateTime>? lastPlayDate,
    Expression<int>? lastWinnerId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastPlayDate != null) 'last_play_date': lastPlayDate,
      if (lastWinnerId != null) 'last_winner_id': lastWinnerId,
    });
  }

  PChatsCompanion copyWith(
      {Value<int>? id,
      Value<DateTime?>? lastPlayDate,
      Value<int?>? lastWinnerId}) {
    return PChatsCompanion(
      id: id ?? this.id,
      lastPlayDate: lastPlayDate ?? this.lastPlayDate,
      lastWinnerId: lastWinnerId ?? this.lastWinnerId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastPlayDate.present) {
      map['last_play_date'] = Variable<DateTime>(lastPlayDate.value);
    }
    if (lastWinnerId.present) {
      map['last_winner_id'] = Variable<int>(lastWinnerId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PChatsCompanion(')
          ..write('id: $id, ')
          ..write('lastPlayDate: $lastPlayDate, ')
          ..write('lastWinnerId: $lastWinnerId')
          ..write(')'))
        .toString();
  }
}

class $PUserChatsTable extends PUserChats
    with TableInfo<$PUserChatsTable, PUserChat> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PUserChatsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES p_users(id) NOT NULL');
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<int> chatId = GeneratedColumn<int>(
      'chat_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'REFERENCES p_chats(id) NOT NULL');
  static const VerificationMeta _winsMeta = const VerificationMeta('wins');
  @override
  late final GeneratedColumn<int> wins = GeneratedColumn<int>(
      'wins', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [userId, chatId, wins];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'p_user_chats';
  @override
  VerificationContext validateIntegrity(Insertable<PUserChat> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    } else if (isInserting) {
      context.missing(_chatIdMeta);
    }
    if (data.containsKey('wins')) {
      context.handle(
          _winsMeta, wins.isAcceptableOrUnknown(data['wins']!, _winsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId, chatId};
  @override
  PUserChat map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PUserChat(
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}chat_id'])!,
      wins: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wins'])!,
    );
  }

  @override
  $PUserChatsTable createAlias(String alias) {
    return $PUserChatsTable(attachedDatabase, alias);
  }
}

class PUserChat extends DataClass implements Insertable<PUserChat> {
  final int userId;
  final int chatId;
  final int wins;
  const PUserChat(
      {required this.userId, required this.chatId, required this.wins});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<int>(userId);
    map['chat_id'] = Variable<int>(chatId);
    map['wins'] = Variable<int>(wins);
    return map;
  }

  PUserChatsCompanion toCompanion(bool nullToAbsent) {
    return PUserChatsCompanion(
      userId: Value(userId),
      chatId: Value(chatId),
      wins: Value(wins),
    );
  }

  factory PUserChat.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PUserChat(
      userId: serializer.fromJson<int>(json['userId']),
      chatId: serializer.fromJson<int>(json['chatId']),
      wins: serializer.fromJson<int>(json['wins']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<int>(userId),
      'chatId': serializer.toJson<int>(chatId),
      'wins': serializer.toJson<int>(wins),
    };
  }

  PUserChat copyWith({int? userId, int? chatId, int? wins}) => PUserChat(
        userId: userId ?? this.userId,
        chatId: chatId ?? this.chatId,
        wins: wins ?? this.wins,
      );
  PUserChat copyWithCompanion(PUserChatsCompanion data) {
    return PUserChat(
      userId: data.userId.present ? data.userId.value : this.userId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      wins: data.wins.present ? data.wins.value : this.wins,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PUserChat(')
          ..write('userId: $userId, ')
          ..write('chatId: $chatId, ')
          ..write('wins: $wins')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, chatId, wins);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PUserChat &&
          other.userId == this.userId &&
          other.chatId == this.chatId &&
          other.wins == this.wins);
}

class PUserChatsCompanion extends UpdateCompanion<PUserChat> {
  final Value<int> userId;
  final Value<int> chatId;
  final Value<int> wins;
  final Value<int> rowid;
  const PUserChatsCompanion({
    this.userId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.wins = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PUserChatsCompanion.insert({
    required int userId,
    required int chatId,
    this.wins = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        chatId = Value(chatId);
  static Insertable<PUserChat> custom({
    Expression<int>? userId,
    Expression<int>? chatId,
    Expression<int>? wins,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (chatId != null) 'chat_id': chatId,
      if (wins != null) 'wins': wins,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PUserChatsCompanion copyWith(
      {Value<int>? userId,
      Value<int>? chatId,
      Value<int>? wins,
      Value<int>? rowid}) {
    return PUserChatsCompanion(
      userId: userId ?? this.userId,
      chatId: chatId ?? this.chatId,
      wins: wins ?? this.wins,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<int>(chatId.value);
    }
    if (wins.present) {
      map['wins'] = Variable<int>(wins.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PUserChatsCompanion(')
          ..write('userId: $userId, ')
          ..write('chatId: $chatId, ')
          ..write('wins: $wins, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$PDatabase extends GeneratedDatabase {
  _$PDatabase(QueryExecutor e) : super(e);
  $PDatabaseManager get managers => $PDatabaseManager(this);
  late final $PUsersTable pUsers = $PUsersTable(this);
  late final $PChatsTable pChats = $PChatsTable(this);
  late final $PUserChatsTable pUserChats = $PUserChatsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [pUsers, pChats, pUserChats];
}

typedef $$PUsersTableCreateCompanionBuilder = PUsersCompanion Function({
  Value<int> id,
  Value<String?> username,
  required String name,
  Value<String?> callMe,
});
typedef $$PUsersTableUpdateCompanionBuilder = PUsersCompanion Function({
  Value<int> id,
  Value<String?> username,
  Value<String> name,
  Value<String?> callMe,
});

class $$PUsersTableTableManager extends RootTableManager<
    _$PDatabase,
    $PUsersTable,
    PUser,
    $$PUsersTableFilterComposer,
    $$PUsersTableOrderingComposer,
    $$PUsersTableCreateCompanionBuilder,
    $$PUsersTableUpdateCompanionBuilder> {
  $$PUsersTableTableManager(_$PDatabase db, $PUsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PUsersTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PUsersTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> callMe = const Value.absent(),
          }) =>
              PUsersCompanion(
            id: id,
            username: username,
            name: name,
            callMe: callMe,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> username = const Value.absent(),
            required String name,
            Value<String?> callMe = const Value.absent(),
          }) =>
              PUsersCompanion.insert(
            id: id,
            username: username,
            name: name,
            callMe: callMe,
          ),
        ));
}

class $$PUsersTableFilterComposer
    extends FilterComposer<_$PDatabase, $PUsersTable> {
  $$PUsersTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get callMe => $state.composableBuilder(
      column: $state.table.callMe,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter pUserChatsRefs(
      ComposableFilter Function($$PUserChatsTableFilterComposer f) f) {
    final $$PUserChatsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.pUserChats,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder, parentComposers) =>
            $$PUserChatsTableFilterComposer(ComposerState($state.db,
                $state.db.pUserChats, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$PUsersTableOrderingComposer
    extends OrderingComposer<_$PDatabase, $PUsersTable> {
  $$PUsersTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get username => $state.composableBuilder(
      column: $state.table.username,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get callMe => $state.composableBuilder(
      column: $state.table.callMe,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PChatsTableCreateCompanionBuilder = PChatsCompanion Function({
  Value<int> id,
  Value<DateTime?> lastPlayDate,
  Value<int?> lastWinnerId,
});
typedef $$PChatsTableUpdateCompanionBuilder = PChatsCompanion Function({
  Value<int> id,
  Value<DateTime?> lastPlayDate,
  Value<int?> lastWinnerId,
});

class $$PChatsTableTableManager extends RootTableManager<
    _$PDatabase,
    $PChatsTable,
    PChat,
    $$PChatsTableFilterComposer,
    $$PChatsTableOrderingComposer,
    $$PChatsTableCreateCompanionBuilder,
    $$PChatsTableUpdateCompanionBuilder> {
  $$PChatsTableTableManager(_$PDatabase db, $PChatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PChatsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PChatsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> lastPlayDate = const Value.absent(),
            Value<int?> lastWinnerId = const Value.absent(),
          }) =>
              PChatsCompanion(
            id: id,
            lastPlayDate: lastPlayDate,
            lastWinnerId: lastWinnerId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime?> lastPlayDate = const Value.absent(),
            Value<int?> lastWinnerId = const Value.absent(),
          }) =>
              PChatsCompanion.insert(
            id: id,
            lastPlayDate: lastPlayDate,
            lastWinnerId: lastWinnerId,
          ),
        ));
}

class $$PChatsTableFilterComposer
    extends FilterComposer<_$PDatabase, $PChatsTable> {
  $$PChatsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get lastPlayDate => $state.composableBuilder(
      column: $state.table.lastPlayDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lastWinnerId => $state.composableBuilder(
      column: $state.table.lastWinnerId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter pUserChatsRefs(
      ComposableFilter Function($$PUserChatsTableFilterComposer f) f) {
    final $$PUserChatsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.pUserChats,
        getReferencedColumn: (t) => t.chatId,
        builder: (joinBuilder, parentComposers) =>
            $$PUserChatsTableFilterComposer(ComposerState($state.db,
                $state.db.pUserChats, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$PChatsTableOrderingComposer
    extends OrderingComposer<_$PDatabase, $PChatsTable> {
  $$PChatsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get lastPlayDate => $state.composableBuilder(
      column: $state.table.lastPlayDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lastWinnerId => $state.composableBuilder(
      column: $state.table.lastWinnerId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PUserChatsTableCreateCompanionBuilder = PUserChatsCompanion Function({
  required int userId,
  required int chatId,
  Value<int> wins,
  Value<int> rowid,
});
typedef $$PUserChatsTableUpdateCompanionBuilder = PUserChatsCompanion Function({
  Value<int> userId,
  Value<int> chatId,
  Value<int> wins,
  Value<int> rowid,
});

class $$PUserChatsTableTableManager extends RootTableManager<
    _$PDatabase,
    $PUserChatsTable,
    PUserChat,
    $$PUserChatsTableFilterComposer,
    $$PUserChatsTableOrderingComposer,
    $$PUserChatsTableCreateCompanionBuilder,
    $$PUserChatsTableUpdateCompanionBuilder> {
  $$PUserChatsTableTableManager(_$PDatabase db, $PUserChatsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PUserChatsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PUserChatsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> userId = const Value.absent(),
            Value<int> chatId = const Value.absent(),
            Value<int> wins = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PUserChatsCompanion(
            userId: userId,
            chatId: chatId,
            wins: wins,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int userId,
            required int chatId,
            Value<int> wins = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PUserChatsCompanion.insert(
            userId: userId,
            chatId: chatId,
            wins: wins,
            rowid: rowid,
          ),
        ));
}

class $$PUserChatsTableFilterComposer
    extends FilterComposer<_$PDatabase, $PUserChatsTable> {
  $$PUserChatsTableFilterComposer(super.$state);
  ColumnFilters<int> get wins => $state.composableBuilder(
      column: $state.table.wins,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PUsersTableFilterComposer get userId {
    final $$PUsersTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.pUsers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PUsersTableFilterComposer(
            ComposerState(
                $state.db, $state.db.pUsers, joinBuilder, parentComposers)));
    return composer;
  }

  $$PChatsTableFilterComposer get chatId {
    final $$PChatsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.pChats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) => $$PChatsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.pChats, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PUserChatsTableOrderingComposer
    extends OrderingComposer<_$PDatabase, $PUserChatsTable> {
  $$PUserChatsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get wins => $state.composableBuilder(
      column: $state.table.wins,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PUsersTableOrderingComposer get userId {
    final $$PUsersTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $state.db.pUsers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PUsersTableOrderingComposer(ComposerState(
                $state.db, $state.db.pUsers, joinBuilder, parentComposers)));
    return composer;
  }

  $$PChatsTableOrderingComposer get chatId {
    final $$PChatsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.chatId,
        referencedTable: $state.db.pChats,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PChatsTableOrderingComposer(ComposerState(
                $state.db, $state.db.pChats, joinBuilder, parentComposers)));
    return composer;
  }
}

class $PDatabaseManager {
  final _$PDatabase _db;
  $PDatabaseManager(this._db);
  $$PUsersTableTableManager get pUsers =>
      $$PUsersTableTableManager(_db, _db.pUsers);
  $$PChatsTableTableManager get pChats =>
      $$PChatsTableTableManager(_db, _db.pChats);
  $$PUserChatsTableTableManager get pUserChats =>
      $$PUserChatsTableTableManager(_db, _db.pUserChats);
}
