part of be_universe_core;

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi() => _AuthenticationApi(
        Api.client,
        baseUrl: 'http://192.168.11.193:3000/',
      );

  @POST('auth/sign-in')
  Future<UserSignInResponse> signIn(@Body() UserSignInRequest request);

  @POST('auth/sign-up')
  Future signUp(@Body() UserRegisterRequest request);

  @POST('auth/social-sign-in')
  Future<SocialSignInResponse> socialSignIn(
      @Body() SocialSignInRequest request);

  @GET('auth/profile')
  Future<ProfileResponse> getProfile(@Header('Authorization') String token);
}
