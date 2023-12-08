import 'package:json_annotation/json_annotation.dart';

part 'food.g.dart';

@JsonSerializable()
class Food {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "shopId")
  int? shopId;

  @JsonKey(name: "fdName")
  String? fdName;

  @JsonKey(name: "foodDescription")
  String? foodDescription;

  @JsonKey(name: "fdCategory")
  int? fdCategory;

  @JsonKey(name: "fdFullPrice")
  double? fdFullPrice;

  @JsonKey(name: "fdThreeBiTwoPrsPrice")
  double? fdThreeBiTwoPrsPrice;

  @JsonKey(name: "fdHalfPrice")
  double? fdHalfPrice;

  @JsonKey(name: "fdQtrPrice")
  double? fdQtrPrice;

  @JsonKey(name: "fullPrsName")
  String? fullPrsName;

  @JsonKey(name: "thrByToPrsName")
  String? thrByToPrsName;

  @JsonKey(name: "halfPrsName")
  String? halfPrsName;

  @JsonKey(name: "qtrPrsName")
  String? qtrPrsName;

  @JsonKey(name: "fdOffFullPrice")
  double? fdOffFullPrice;

  @JsonKey(name: "fdOffThreeByTwoPrice")
  double? fdOffThreeByTwoPrice;

  @JsonKey(name: "fdOffHalfPrice")
  double? fdOffHalfPrice;

  @JsonKey(name: "fdOffQtrPrice")
  double? fdOffQtrPrice;


  @JsonKey(name: "offerName")
  String? offerName;

  @JsonKey(name: "fdIsLoos")
  String? fdIsLoos;

  @JsonKey(name: "cookTime")
  int? cookTime;

  @JsonKey(name: "fdImg")
  String? fdImg;

  @JsonKey(name: "fdIsToday")
  String? fdIsToday;

  @JsonKey(name: "fdIsQuick")
  String? fdIsQuick;

  @JsonKey(name: "fdIsAvailable")
  String? fdIsAvailable;

  @JsonKey(name: "fdIsHide")
  String? fdIsHide;

  @JsonKey(name: "offer")
  String? offer;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "updatedAt")
  String? updatedAt;

  // Regular constructor
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
      this.fullPrsName,
      this.thrByToPrsName,
      this.halfPrsName,
      this.qtrPrsName,
      this.fdOffFullPrice,
      this.fdOffThreeByTwoPrice,
      this.fdOffHalfPrice,
      this.fdOffQtrPrice,
      this.offerName,
      this.fdIsLoos,
      this.cookTime,
      this.fdImg,
      this.fdIsToday,
      this.fdIsQuick,
      this.fdIsAvailable,
      this.fdIsHide,
      this.offer,
      this.createdAt,
      this.updatedAt);

  // Copy constructor
  Food.copy(Food other)
      : id = other.id,
        shopId = other.shopId,
        fdName = other.fdName,
        foodDescription = other.foodDescription,
        fdCategory = other.fdCategory,
        fdFullPrice = other.fdFullPrice,
        fdThreeBiTwoPrsPrice = other.fdThreeBiTwoPrsPrice,
        fdHalfPrice = other.fdHalfPrice,
        fdQtrPrice = other.fdQtrPrice,
        fdOffFullPrice = other.fdOffFullPrice,
        fdOffThreeByTwoPrice = other.fdOffThreeByTwoPrice,
        fdOffHalfPrice = other.fdOffHalfPrice,
        fdOffQtrPrice = other.fdOffQtrPrice,
        offerName = other.offerName,
        fdIsLoos = other.fdIsLoos,
        cookTime = other.cookTime,
        fdImg = other.fdImg,
        fdIsToday = other.fdIsToday,
        fdIsQuick = other.fdIsQuick,
        fdIsAvailable = other.fdIsAvailable,
        fdIsHide = other.fdIsHide,
        offer = other.offer,
        createdAt = other.createdAt,
        updatedAt = other.updatedAt;

  // From JSON
  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);

  // To JSON
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
