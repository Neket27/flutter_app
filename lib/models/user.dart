import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final String password;
  final String? firstName;
  final String? lastName;

  User({
    required this.username,
    required this.password,
    this.firstName,
    this.lastName,
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
