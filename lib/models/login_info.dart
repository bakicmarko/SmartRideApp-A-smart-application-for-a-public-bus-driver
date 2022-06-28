// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'login_info.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: true, createFactory: true)
class LogInInfo {
  String email;
  String password;

  LogInInfo(this.email, this.password);
  factory LogInInfo.fromJson(Map<String, dynamic> json) => _$LogInInfoFromJson(json);

  Map<String, dynamic> toJson() => _$LogInInfoToJson(this);
}
