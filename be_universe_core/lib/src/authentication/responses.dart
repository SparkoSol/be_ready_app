part of be_universe_core;

@JsonSerializable(
  createToJson: false,
)
class UserSignInResponse {
  UserSignInResponse(this.signInToken);

  @JsonKey(name: 'access_token')
  final String signInToken;

  factory UserSignInResponse.fromJson(_Json json) {
    return _$UserSignInResponseFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
class SocialSignInResponse {
  SocialSignInResponse(this.socialToken);

  @JsonKey(name: 'access_token')
  final String socialToken;

  factory SocialSignInResponse.fromJson(_Json json) {
    return _$SocialSignInResponseFromJson(json);
  }
}

@JsonSerializable(createToJson: false)
@HiveType(typeId: 0)
class ProfileResponse extends HiveObject {
  ProfileResponse({
    required this.userid,
    required this.username,
    required this.isVerified,
    this.image,
    required this.name,
    required this.email,
    this.fcmToken,
    this.isPremium,
    this.businessId,
    required this.loginVia,
    this.purchase,
  });

  @HiveField(0)
  @JsonKey(name: '_id')
  final String userid;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final bool isVerified;
  @HiveField(3)
  String name;
  @HiveField(4)
  String email;
  @HiveField(5)
  String loginVia;
  @HiveField(6)
  String? image;
  @HiveField(7)
  String? fcmToken;

  @HiveField(8)
  bool? isPremium;
  @HiveField(9)
  String? businessId;
  @HiveField(10)
  PurchaseModel? purchase;

  factory ProfileResponse.fromJson(_Json json) {
    return _$ProfileResponseFromJson(json);
  }
}
