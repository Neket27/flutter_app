import 'package:json_annotation/json_annotation.dart';

part 'DialogListElm.g.dart';

@JsonSerializable()
class DialogListElm {
  final String Login;
  final String FirstName;
  final String LastName;
  final int Unread;
  DialogListElm({
    required this.Login,
    required this.FirstName,
    required this.LastName,
    required this.Unread,
  });

  factory DialogListElm.fromJson(Map<String, dynamic> json) =>
      _$DialogListElmFromJson(json);

  Map<String, dynamic> toJson() => _$DialogListElmToJson(this);
}