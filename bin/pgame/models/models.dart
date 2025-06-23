import 'package:teledart/model.dart';

final class UserEntity {
  final int id;
  final String? username;
  final String fullname;

  const UserEntity({
    required this.id,
    this.username,
    required this.fullname,
  });
}

extension UserEntityX on UserEntity {
  String get displayName =>
      username != null && username!.isNotEmpty ? '@$username' : fullname;
}

extension UserX on User {
  UserEntity toUserEntity() {
    return UserEntity(
      id: id,
      username: username,
      fullname: lastName == null ? firstName : '$firstName $lastName',
    );
  }
}