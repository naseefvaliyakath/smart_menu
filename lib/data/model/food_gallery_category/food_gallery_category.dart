import 'package:json_annotation/json_annotation.dart';
part 'food_gallery_category.g.dart';

@JsonSerializable()
class FoodGalleryCategory {
  @JsonKey(name : "id")
  int? id;

  @JsonKey(name : "name")
  String? name;

  @JsonKey(name : "createdAt")
  String? createdAt;

  FoodGalleryCategory(
      this.id,
      this.name,
      this.createdAt
      );

  factory FoodGalleryCategory.fromJson(Map<String, dynamic> json) => _$FoodGalleryCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FoodGalleryCategoryToJson(this);
}
