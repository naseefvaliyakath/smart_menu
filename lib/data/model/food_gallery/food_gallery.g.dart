// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_gallery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodGalleryItem _$FoodGalleryItemFromJson(Map<String, dynamic> json) =>
    FoodGalleryItem(
      json['id'] as int?,
      json['name'] as String?,
      json['fdGallCatId'] as int?,
      json['fdImg'] as String?,
      json['created_date'] as String?,
    );

Map<String, dynamic> _$FoodGalleryItemToJson(FoodGalleryItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'fdGallCatId': instance.fdGallCatId,
      'fdImg': instance.fdImg,
      'created_date': instance.createdAt,
    };
