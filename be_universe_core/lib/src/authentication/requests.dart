part of be_universe_core;

@JsonSerializable(createFactory: false)
class UserSignInRequest {
  const UserSignInRequest({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  Map<String, dynamic> toJson() => _$UserSignInRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class UserRegisterRequest {
  const UserRegisterRequest(
      {required this.email,
      required this.password,
      required this.name,
      required this.username,
      required this.loginVia,
      required this.role});

  final String email;
  final String password;
  final String name;
  final String role;
  final String username;
  final String loginVia;

  _Json toJson() => _$UserRegisterRequestToJson(this);
}

@JsonSerializable(createFactory: false)
class SocialSignInRequest {
  const SocialSignInRequest(
      {required this.username,
      required this.idToken,
      required this.name,
      required this.email,
      required this.image,
      required this.loginVia});

  final String username;
  final String email;
  final String name;
  final String loginVia;
  final String idToken;
  final String image;

  _Json toJson() => _$SocialSignInRequestToJson(this);
}
