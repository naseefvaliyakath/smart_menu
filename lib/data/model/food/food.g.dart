// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      id: json['id'] as int?,
      shopId: json['shopId'] as int?,
      fdName: json['fdName'] as String?,
      foodDescription: json['foodDescription'] as String?,
      fdCategory: json['fdCategory'] as int?,
      fdFullPrice: (json['fdFullPrice'] as num?)?.toDouble(),
      fdThreeBiTwoPrsPrice: (json['fdThreeBiTwoPrsPrice'] as num?)?.toDouble(),
      fdHalfPrice: (json['fdHalfPrice'] as num?)?.toDouble(),
      fdQtrPrice: (json['fdQtrPrice'] as num?)?.toDouble(),
      fullPrsName: json['fullPrsName'] as String?,
      thrByToPrsName: json['thrByToPrsName'] as String?,
      halfPrsName: json['halfPrsName'] as String?,
      qtrPrsName: json['qtrPrsName'] as String?,
      fdOffFullPrice: (json['fdOffFullPrice'] as num?)?.toDouble(),
      fdOffThreeByTwoPrice: (json['fdOffThreeByTwoPrice'] as num?)?.toDouble(),
      fdOffHalfPrice: (json['fdOffHalfPrice'] as num?)?.toDouble(),
      fdOffQtrPrice: (json['fdOffQtrPrice'] as num?)?.toDouble(),
      offerName: json['offerName'] as String?,
      fdIsLoos: json['fdIsLoos'] as String?,
      cookTime: json['cookTime'] as int?,
      fdImg: json['fdImg'] as String?,
      fdIsToday: json['fdIsToday'] as String?,
      fdIsQuick: json['fdIsQuick'] as String?,
      fdIsAvailable: json['fdIsAvailable'] as String?,
      fdIsHide: json['fdIsHide'] as String?,
      offer: json['offer'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
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
