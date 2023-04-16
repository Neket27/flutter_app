import 'package:json_annotation/json_annotation.dart';

part 'users.g.dart';

@JsonSerializable()
class Users {
  Users();

  late List users;
  late num total;
  late num skip;
  late num limit;
  
  factory Users.fromJson(Map<String,dynamic> json) => _$UsersFromJson(json);
  Map<String, dynamic> toJson() => _$UsersToJson(this);


}
