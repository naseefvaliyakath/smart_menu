import 'package:json_annotation/json_annotation.dart';

part 'payment_order_razor_pay.g.dart';

@JsonSerializable()
class PaymentOrderRazorPay {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'entity')
  String? entity;

  @JsonKey(name: 'amount')
  int? amount;

  @JsonKey(name: 'amount_paid')
  int? amountPaid;

  @JsonKey(name: 'amount_due')
  int? amountDue;

  @JsonKey(name: 'currency')
  String? currency;

  @JsonKey(name: 'receipt')
  String? receipt;

  @JsonKey(name: 'offer_id')
  dynamic offerId;

  @JsonKey(name: 'status')
  String? status;

  @JsonKey(name: 'key')
  String? key;

  @JsonKey(name: 'attempts')
  int? attempts;

  @JsonKey(name: 'notes')
  Map<String, dynamic>? notes;

  @JsonKey(name: 'created_at')
  int? createdAt;


  PaymentOrderRazorPay({
    this.id,
    this.entity,
    this.amount,
    this.amountPaid,
    this.amountDue,
    this.currency,
    this.receipt,
    this.offerId,
    this.status,
    this.key,
    this.attempts,
    this.notes,
    this.createdAt,
  });

  factory PaymentOrderRazorPay.fromJson(Map<String, dynamic> json) => _$PaymentOrderRazorPayFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentOrderRazorPayToJson(this);
}
