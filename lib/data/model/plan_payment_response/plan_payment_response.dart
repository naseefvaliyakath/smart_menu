import 'package:json_annotation/json_annotation.dart';

part 'plan_payment_response.g.dart';

@JsonSerializable()
class PlanPaymentResponse{


  @JsonKey(name : "planName")
  String? planName;

  @JsonKey(name : "expiryDate")
  String? expiryDate;





  PlanPaymentResponse(
      this.planName,
      this.expiryDate,
      );

  factory PlanPaymentResponse.fromJson(Map<String, dynamic> json) => _$PlanPaymentResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PlanPaymentResponseToJson(this);
}