// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WebMenu _$WebMenuFromJson(Map<String, dynamic> json) => WebMenu(
      menuId: json['menuId'] as int?,
      showAllFood: json['showAllFood'] as String?,
      showAvailableFood: json['showAvailableFood'] as String?,
      showOfferFood: json['showOfferFood'] as String?,
      showTodayFood: json['showTodayFood'] as String?,
      showQuickFood: json['showQuickFood'] as String?,
      showFoodPrice: json['showFoodPrice'] as String?,
      showFoodDescription: json['showFoodDescription'] as String?,
      shopId: json['shopId'] as int?,
      mainColor: json['mainColor'] as String?,
      secondColor: json['secondColor'] as String?,
      titleColor: json['titleColor'] as String?,
      cardDesign: json['cardDesign'] as int?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$WebMenuToJson(WebMenu instance) => <String, dynamic>{
      'menuId': instance.menuId,
      'showAllFood': instance.showAllFood,
      'showAvailableFood': instance.showAvailableFood,
      'showOfferFood': instance.showOfferFood,
      'showTodayFood': instance.showTodayFood,
      'showQuickFood': instance.showQuickFood,
      'showFoodPrice': instance.showFoodPrice,
      'showFoodDescription': instance.showFoodDescription,
      'shopId': instance.shopId,
      'mainColor': instance.mainColor,
      'secondColor': instance.secondColor,
      'titleColor': instance.titleColor,
      'cardDesign': instance.cardDesign,
      'status': instance.status,
    };
