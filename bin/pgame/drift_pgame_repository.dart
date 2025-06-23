import 'package:drift/drift.dart';

import '../database/database.dart';
import 'models/models.dart';
import 'models/registration_result.dart';
import 'pgame_repository.dart';

class DriftPGameRepository implements PGameRepository {
  final PDatabase db;

  DriftPGameRepository(this.db);

  @override
  Future<RegistrationResult> registerUser(UserEntity user, int chatId) async {
    try {
      return await db.transaction(() async {
        final chatExists = await (db.select(db.pChats)
              ..where((tbl) => tbl.id.equals(chatId)))
            .getSingleOrNull();
        if (chatExists == null) {
          await db.into(db.pChats).insert(PChatsCompanion(id: Value(chatId)));
        }
        // Ensure user exists
        final userId = user.id;
        final userExists = await (db.select(db.pUsers)
              ..where((tbl) => tbl.id.equals(userId)))
            .getSingleOrNull();
        if (userExists == null) {
          await db.into(db.pUsers).insert(PUsersCompanion(
                id: Value(userId),
                username: user.username != null
                    ? Value(user.username)
                    : const Value.absent(),
                name: Value(user.fullname),
              ));
        }
        // Check if already registered
        final reg = await (db.select(db.pUserChats)
              ..where((tbl) =>
                  tbl.userId.equals(userId) & tbl.chatId.equals(chatId)))
            .getSingleOrNull();
        if (reg != null) {
          return RegistrationResult.alreadyRegistered;
        }
        // Register
        await db.into(db.pUserChats).insert(PUserChatsCompanion(
              userId: Value(userId),
              chatId: Value(chatId),
            ));
        return RegistrationResult.success;
      });
    } catch (_) {
      return RegistrationResult.error;
    }
  }

  @override
  Future<List<UserEntity>> getRegisteredUsers(int chatId) async {
    final userChats = await (db.select(db.pUserChats)
          ..where((tbl) => tbl.chatId.equals(chatId)))
        .get();
    final userIds = userChats.map((e) => e.userId).toList();
    if (userIds.isEmpty) return [];
    final users =
        await (db.select(db.pUsers)..where((u) => u.id.isIn(userIds))).get();
    return users
        .map((u) => UserEntity(
              id: u.id,
              username: u.username,
              fullname: u.name,
            ))
        .toList();
  }

  @override
  Future<void> incrementWins(int userId, int chatId) async {
    await db.transaction(() async {
      final userChat = await (db.select(db.pUserChats)
            ..where(
                (tbl) => tbl.userId.equals(userId) & tbl.chatId.equals(chatId)))
          .getSingleOrNull();
      if (userChat != null) {
        await db.into(db.pUserChats).insertOnConflictUpdate(
              PUserChatsCompanion(
                userId: Value(userId),
                chatId: Value(chatId),
                wins: Value(userChat.wins + 1),
              ),
            );
        await (db.update(db.pChats)..where((tbl) => tbl.id.equals(chatId)))
            .write(
          PChatsCompanion(
            lastPlayDate: Value(DateTime.now().toUtc()),
            lastWinnerId: Value(userId),
          ),
        );
      }
    });
  }

  @override
  Future<List<(UserEntity, int)>> getResults(int chatId) {
    return db.transaction(() async {
      final results = await (db.select(db.pUserChats)
            ..where((tbl) =>
                tbl.chatId.equals(chatId) & tbl.wins.isBiggerThanValue(0))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.wins)])
            ..limit(10))
          .get();

      final userIds = results.map((e) => e.userId).toList();
      if (userIds.isEmpty) return [];

      final users =
          await (db.select(db.pUsers)..where((u) => u.id.isIn(userIds))).get();
      return results.map((w) {
        final user = users.firstWhere((u) => u.id == w.userId);
        return (
          UserEntity(
            id: user.id,
            username: user.username,
            fullname: user.name,
          ),
          w.wins
        );
      }).toList();
    });
  }

  @override
  Future<DateTime?> getLastPlayDate(int chatId) async {
    final chat = await (db.select(db.pChats)
          ..where((tbl) => tbl.id.equals(chatId)))
        .getSingleOrNull();
    return chat?.lastPlayDate;
  }

  /// Returns the last winner's user ID for the given chat, or null if never played.
  Future<int?> getLastWinnerId(int chatId) async {
    final chat = await (db.select(db.pChats)
          ..where((tbl) => tbl.id.equals(chatId)))
        .getSingleOrNull();
    return chat?.lastWinnerId;
  }

  @override
  Future<UserEntity?> getLastWinner(int chatId) {
    return db.transaction(() async {
      final lastWinnerId = await getLastWinnerId(chatId);
      if (lastWinnerId == null) return null;
      final user = await (db.select(db.pUsers)
            ..where((u) => u.id.equals(lastWinnerId)))
          .getSingleOrNull();
      if (user == null) return null;
      return UserEntity(
        id: user.id,
        username: user.username,
        fullname: user.name,
      );
    });
  }
}
