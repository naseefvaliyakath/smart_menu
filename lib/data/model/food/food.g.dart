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
      json['fullPrsName'] as String?,
      json['thrByToPrsName'] as String?,
      json['halfPrsName'] as String?,
      json['qtrPrsName'] as String?,
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
      json['fdIsHide'] as String?,
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
      'fullPrsName': instance.fullPrsName,
      'thrByToPrsName': instance.thrByToPrsName,
      'halfPrsName': instance.halfPrsName,
      'qtrPrsName': instance.qtrPrsName,
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
      'fdIsHide': instance.fdIsHide,
      'offer': instance.offer,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
