// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      json['id'] as int?,
      json['shopId'] as int?,
      json['fdName'] as String?,
      json['foodDescription'] as String?,
      json['fdCategory'] as int?,
      (json['fdFullPrice'] as num?)?.toDouble(),
      (json['fdThreeBiTwoPrsPrice'] as num?)?.toDouble(),
      (json['fdHalfPrice'] as num?)?.toDouble(),
      (json['fdQtrPrice'] as num?)?.toDouble(),
      (json['fdOffFullPrice'] as num?)?.toDouble(),
      (json['fdOffThreeByTwoPrice'] as num?)?.toDouble(),
      (json['fdOffHalfPrice'] as num?)?.toDouble(),
      (json['fdOffQtrPrice'] as num?)?.toDouble(),
      json['offerName'] as String?,
      json['fdIsLoos'] as String?,
      json['cookTime'] as int?,
      json['fdImg'] as String?,
      json['fdIsToday'] as String?,
      json['fdIsQuick'] as String?,
      json['fdIsAvailable'] as String?,
      json['fdIsSpecial'] as String?,
      json['offer'] as String?,
      json['createdAt'] as String?,
      json['updatedAt'] as String?,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'shopId': instance.shopId,
      'fdName': instance.fdName,
      'foodDescription': instance.foodDescription,
      'fdCategory': instance.fdCategory,
      'fdFullPrice': instance.fdFullPrice,
      'fdThreeBiTwoPrsPrice': instance.fdThreeBiTwoPrsPrice,
      'fdHalfPrice': instance.fdHalfPrice,
      'fdQtrPrice': instance.fdQtrPrice,
      'fdOffFullPrice': instance.fdOffFullPrice,
      'fdOffThreeByTwoPrice': instance.fdOffThreeByTwoPrice,
      'fdOffHalfPrice': instance.fdOffHalfPrice,
      'fdOffQtrPrice': instance.fdOffQtrPrice,
      'offerName': instance.offerName,
      'fdIsLoos': instance.fdIsLoos,
      'cookTime': instance.cookTime,
      'fdImg': instance.fdImg,
      'fdIsToday': instance.fdIsToday,
      'fdIsQuick': instance.fdIsQuick,
      'fdIsAvailable': instance.fdIsAvailable,
      'fdIsSpecial': instance.fdIsSpecial,
      'offer': instance.offer,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
