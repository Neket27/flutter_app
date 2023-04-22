import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String? maidenName;
  final bool online;
  final String? avatar;

  User({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    this.maidenName,
    required this.online,
    this.avatar,

  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@JsonSerializable()
class UserList {
  final List<User> users;

  UserList({
    required this.users
  });

  factory UserList.fromJson(Map<String, dynamic> json) =>
      _$UserListFromJson(json);

}
