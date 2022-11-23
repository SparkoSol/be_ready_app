part of be_universe_core;

@JsonSerializable(
  createToJson: false,
)
class UserSignInResponse {
  UserSignInResponse(this.signintoken);

  @JsonKey(name: 'access_token')
  final String signintoken;

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
class ProfileResponse {
  const ProfileResponse(this.userid, this.username);

  @JsonKey(name: '_id')
  final String userid;
  @JsonKey(name: 'username')
  final String username;

  factory ProfileResponse.fromJson(_Json json) {
    return _$ProfileResponseFromJson(json);
  }
}
