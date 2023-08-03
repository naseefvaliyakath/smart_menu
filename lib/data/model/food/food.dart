import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';




@JsonSerializable()
class Food {
//? flutter pub run build_runner build --delete-conflicting-outputs
  @JsonKey(name : "id")
  int? id;

  @JsonKey(name : "shopId")
  int? shopId;

  @JsonKey(name : "fdName")
  String? fdName;

  @JsonKey(name : "foodDescription")
  String? foodDescription;

  @JsonKey(name : "fdCategory")
  int? fdCategory;

  @JsonKey(name : "fdFullPrice")
  double? fdFullPrice;

  @JsonKey(name : "fdThreeBiTwoPrsPrice")
  double? fdThreeBiTwoPrsPrice;

  @JsonKey(name : "fdHalfPrice")
  double? fdHalfPrice;

  @JsonKey(name : "fdQtrPrice")
  double? fdQtrPrice;

  @JsonKey(name : "fdIsLoos")
  String? fdIsLoos;

  @JsonKey(name : "cookTime")
  int? cookTime;

  @JsonKey(name : "fdImg")
  String? fdImg;

  @JsonKey(name : "fdIsToday")
  String? fdIsToday;

  @JsonKey(name : "fdIsQuick")
  String? fdIsQuick;

  @JsonKey(name : "fdIsAvailable")
  String? fdIsAvailable;

  @JsonKey(name : "fdIsSpecial")
  String? fdIsSpecial;

  @JsonKey(name : "offer")
  String? offer;

  @JsonKey(name : "createdAt")
  String? createdAt;

  @JsonKey(name : "updatedAt")
  String? updatedAt;

  Food(
      this.id,
      this.shopId,
      this.fdName,
      this.foodDescription,
      this.fdCategory,
      this.fdFullPrice,
      this.fdThreeBiTwoPrsPrice,
      this.fdHalfPrice,
      this.fdQtrPrice,
      this.fdIsLoos,
      this.cookTime,
      this.fdImg,
      this.fdIsToday,
      this.fdIsQuick,
      this.fdIsAvailable,
      this.fdIsSpecial,
      this.offer,
      this.createdAt,
      this.updatedAt,
      );

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
