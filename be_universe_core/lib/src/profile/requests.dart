part of be_universe_core;

@JsonSerializable(createFactory: false, explicitToJson: true)
class ProfileUpdateRequest {
  ProfileUpdateRequest({
    this.name,
    this.image,
  });

  @JsonKey(includeIfNull: false)
  String? name;
  @JsonKey(includeIfNull: false)
  String? image;

  Map<String, dynamic> toJson() => _$ProfileUpdateRequestToJson(this);
}

@JsonSerializable(createFactory: false, explicitToJson: true)
class UpdateReceiptRequest {
  UpdateReceiptRequest({
    required this.receiptToken,
  });

  String receiptToken;

  Map<String, dynamic> toJson() => _$UpdateReceiptRequestToJson(this);
}
