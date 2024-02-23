import 'package:json_annotation/json_annotation.dart';

part 'web_menu.g.dart';

@JsonSerializable()
class WebMenu {
  @JsonKey(name: "menuId")
  int? menuId;

  @JsonKey(name: "showAllFood")
  String? showAllFood;

  @JsonKey(name: "showAvailableFood")
  String? showAvailableFood;

  @JsonKey(name: "showOfferFood")
  String? showOfferFood;

  @JsonKey(name: "showTodayFood")
  String? showTodayFood;

  @JsonKey(name: "showQuickFood")
  String? showQuickFood;

  @JsonKey(name: "showFoodPrice")
  String? showFoodPrice;

  @JsonKey(name: "showFoodDescription")
  String? showFoodDescription;

  @JsonKey(name: "shopId")
  int? shopId;

  @JsonKey(name: "mainColor")
  String? mainColor;

  @JsonKey(name: "secondColor")
  String? secondColor;

  @JsonKey(name: "titleColor")
  String? titleColor;

  @JsonKey(name: "cardDesign")
  int? cardDesign;

  @JsonKey(name: "status")
  String? status;

  WebMenu({
    this.menuId,
    this.showAllFood,
    this.showAvailableFood,
    this.showOfferFood,
    this.showTodayFood,
    this.showQuickFood,
    this.showFoodPrice,
    this.showFoodDescription,
    this.shopId,
    this.mainColor,
    this.secondColor,
    this.titleColor,
    this.cardDesign,
    this.status,
  });

  factory WebMenu.fromJson(Map<String, dynamic> json) => _$WebMenuFromJson(json);

  Map<String, dynamic> toJson() => _$WebMenuToJson(this);
}
