import 'package:be_ready_app/src/models/_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AppUser extends Model {
  AppUser({
    required this.email,
    required this.name,
    required this.password,
  });

  final String email;
  String name;

  String? password;

  @override
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
