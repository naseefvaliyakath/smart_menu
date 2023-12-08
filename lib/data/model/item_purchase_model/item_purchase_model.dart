import 'package:json_annotation/json_annotation.dart';
part 'item_purchase_model.g.dart';

@JsonSerializable()
class ItemPurchaseModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "link")
  final String link;


  ItemPurchaseModel({
    required this.id,
    required this.name,
    required this.link,

  });

  factory ItemPurchaseModel.fromJson(Map<String, dynamic> json) => _$ItemPurchaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPurchaseModelToJson(this);


}
