import 'package:json_annotation/json_annotation.dart';

part 'plan.g.dart';

@JsonSerializable()
class Plan {
  @JsonKey(name: "planId")
  int? planId;

  @JsonKey(name: "planName")
  String? planName;

  @JsonKey(name: "imgUrl")
  String? imgLink;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "currency")
  String? currency;

  @JsonKey(name: "durationMonths")
  int? durationMonths;

  @JsonKey(name: "maxUsers")
  int? maxUsers;

  @JsonKey(name: "feature1")
  int? feature1;

  @JsonKey(name: "feature2")
  int? feature2;

  @JsonKey(name: "createdAt")
  String? createdAt;

  @JsonKey(name: "updatedAt")
  String? updatedAt;

  Plan({
    this.planId,
    this.planName,
    this.description,
    this.price,
    this.currency,
    this.durationMonths,
    this.maxUsers,
    this.feature1,
    this.feature2,
    this.createdAt,
    this.updatedAt,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => _$PlanFromJson(json);
  Map<String, dynamic> toJson() => _$PlanToJson(this);
}
