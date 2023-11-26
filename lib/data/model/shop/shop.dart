import 'package:json_annotation/json_annotation.dart';

part 'shop.g.dart';

@JsonSerializable()
class Shop {
  @JsonKey(name: "shopId")
  int? shopId;

  @JsonKey(name: "shopName")
  String? shopName;

  @JsonKey(name: "phoneNumber")
  String? phoneNumber;

  @JsonKey(name: "state")
  String? state;

  @JsonKey(name: "district")
  String? district;

  @JsonKey(name: "plan")
  String? plan;

  @JsonKey(name: "expiryDate")
  String? expiryDate;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "token")
  String? token;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "updatedAt")
  String? updatedAt;

  Shop(
      this.shopId,
      this.shopName,
      this.phoneNumber,
      this.state,
      this.district,
      this.plan,
      this.expiryDate,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.token);

  factory Shop.fromJson(Map<String, dynamic> json) => _$ShopFromJson(json);
  Map<String, dynamic> toJson() => _$ShopToJson(this);
}
