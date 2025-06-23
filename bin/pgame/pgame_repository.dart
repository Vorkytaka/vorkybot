import 'models/models.dart';
import 'models/registration_result.dart';

abstract interface class PGameRepository {
  Future<RegistrationResult> registerUser(UserEntity user, int chatId);

  Future<List<UserEntity>> getRegisteredUsers(int chatId);

  Future<void> incrementWins(int userId, int chatId);

  Future<List<(UserEntity, int)>> getResults(int chatId);

  /// Returns the last play date (UTC) for the given chat, or null if never played.
  Future<DateTime?> getLastPlayDate(int chatId);

  Future<UserEntity?> getLastWinner(int chatId);
}
