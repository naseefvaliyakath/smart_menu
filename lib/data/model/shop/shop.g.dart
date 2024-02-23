// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shop _$ShopFromJson(Map<String, dynamic> json) => Shop(
      shopId: json['shopId'] as int?,
      shopName: json['shopName'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String?,
      state: json['state'] as String?,
      district: json['district'] as String?,
      plan: json['plan'] as String?,
      expiryDate: json['expiryDate'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$ShopToJson(Shop instance) => <String, dynamic>{
      'shopId': instance.shopId,
      'shopName': instance.shopName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'state': instance.state,
      'district': instance.district,
      'plan': instance.plan,
      'expiryDate': instance.expiryDate,
      'status': instance.status,
      'token': instance.token,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
