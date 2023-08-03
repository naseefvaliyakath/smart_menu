import 'package:json_annotation/json_annotation.dart';
part 'food_gallery.g.dart';

@JsonSerializable()
class FoodGalleryItem {
  @JsonKey(name : "id")
  int? id;

  @JsonKey(name : "name")
  String? name;

  @JsonKey(name : "category")
  String? category;

  @JsonKey(name : "fdImg")
  String? fdImg;

  @JsonKey(name : "created_date")
  String? createdAt;

  FoodGalleryItem(
      this.id,
      this.name,
      this.category,
      this.fdImg,
      this.createdAt
      );

  factory FoodGalleryItem.fromJson(Map<String, dynamic> json) => _$FoodGalleryItemFromJson(json);
  Map<String, dynamic> toJson() => _$FoodGalleryItemToJson(this);
}
