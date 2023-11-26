import 'package:json_annotation/json_annotation.dart';
part 'app_update_model.g.dart';

@JsonSerializable()
class AppUpdateModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "platform")
  final String platform;
  @JsonKey(name: "version")
  final String version;
  @JsonKey(name: "forced")
  final String forced;
  @JsonKey(name: "message")
  final String message;

  AppUpdateModel({
    required this.id,
    required this.platform,
    required this.version,
    required this.forced,
    required this.message,
  });

  factory AppUpdateModel.fromJson(Map<String, dynamic> json) => _$AppUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateModelToJson(this);


}
