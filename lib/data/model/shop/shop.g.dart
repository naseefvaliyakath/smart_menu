// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      json['shopId'] as int?,
      json['shopName'] as String?,
      json['phoneNumber'] as String?,
      json['state'] as String?,
      json['district'] as String?,
      json['plan'] as String?,
      json['expiryDate'] as String?,
      json['status'] as String?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
      json['token'] as String?,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'phoneNumber': instance.phoneNumber,
      'state': instance.state,
      'district': instance.district,
      'plan': instance.plan,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'token': instance.token,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
