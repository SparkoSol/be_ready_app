part of be_universe_core;

@JsonSerializable()
@HiveType(typeId: 1)
class PurchaseModel extends HiveObject {
  PurchaseModel({
    this.originalTransactionId,
    this.receiptToken,
  });

  factory PurchaseModel.fromJson(_Json json) {
    return _$PurchaseModelFromJson(json);
  }

  @HiveField(0)
  String? originalTransactionId;
  @HiveField(1)
  String? receiptToken;

  Map<String, dynamic> toJson() => _$PurchaseModelToJson(this);
}
