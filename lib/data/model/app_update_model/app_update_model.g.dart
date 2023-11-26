// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdateModel _$AppUpdateModelFromJson(Map<String, dynamic> json) =>
    AppUpdateModel(
      id: json['id'] as int,
      platform: json['platform'] as String,
      version: json['version'] as String,
      forced: json['forced'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AppUpdateModelToJson(AppUpdateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'version': instance.version,
      'forced': instance.forced,
      'message': instance.message,
    };
