import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category{

  @JsonKey(name : "id")
  int? id;

  @JsonKey(name : "name")
  String? name;

  @JsonKey(name : "shopId")
  int? shopId;

  @JsonKey(name : "createdAt")
  String? createdAt;

  @JsonKey(name : "updatedAt")
  String? updatedAt;



  Category(
      this.id,
      this.name,
      this.shopId,
      this.createdAt,
      this.updatedAt,
);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}