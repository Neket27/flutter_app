import 'package:json_annotation/json_annotation.dart';

part 'SearchedUser.g.dart';

@JsonSerializable()
class SearchedUser {
  final String Login;
  final String FirstName;
  final String LastName;
  SearchedUser({
    required this.Login,
    required this.FirstName,
    required this.LastName,
  });

  factory SearchedUser.fromJson(Map<String, dynamic> json) =>
      _$SearchedUserFromJson(json);

  Map<String, dynamic> toJson() => _$SearchedUserToJson(this);
}