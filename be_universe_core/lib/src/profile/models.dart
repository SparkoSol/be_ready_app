part of be_universe_core;

@JsonSerializable()
@HiveType(typeId: 1)
class PurchaseModel extends HiveObject {
  PurchaseModel({
    required this.latestReceiptInfo,
    required this.receiptToken,
  });

  factory PurchaseModel.fromJson(Json json) {
    return _$PurchaseModelFromJson(json);
  }

  @HiveField(0)
  String? receiptToken;
  @HiveField(1)
  List<LatestReceiptInfo>? latestReceiptInfo;

  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 2)
class LatestReceiptInfo extends HiveObject {
  LatestReceiptInfo(
      {this.expiresDateMs,
      this.isTrialPeriod,
      this.productId,
      this.transactionId,
      this.purchaseDateMs});

  factory LatestReceiptInfo.fromJson(Json json) {
    return _$LatestReceiptInfoFromJson(json);
  }

  @HiveField(0)
  @JsonKey(name: 'product_id')
  String? productId;
  @HiveField(1)
  @JsonKey(name: 'purchase_date_ms')
  String? purchaseDateMs;
  @HiveField(2)
  @JsonKey(name: 'expires_date_ms')
  String? expiresDateMs;
  @HiveField(3)
  @JsonKey(name: 'is_trial_period')
  String? isTrialPeriod;
  @HiveField(4)
  @JsonKey(name: 'transaction_id')
  String? transactionId;

  Map<String, dynamic> toJson() => _$LatestReceiptInfoToJson(this);
}
