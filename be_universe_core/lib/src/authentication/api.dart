part of be_universe_core;

@RestApi()
abstract class AuthenticationApi {
  factory AuthenticationApi() => _AuthenticationApi(
        Api.client,
      );

  @POST('auth/sign-in')
  Future<UserSignInResponse> signIn(@Body() UserSignInRequest request);

  @POST('auth/sign-up')
  Future<ProfileResponse> signUp(@Body() UserRegisterRequest request);

  @POST('auth/social-sign-in')
  Future<SocialSignInResponse> socialSignIn(
      @Body() SocialSignInRequest request);

  @GET('auth/profile')
  Future<ProfileResponse> getProfile(@Header('Authorization') String token);

  @POST('auth/sign-out')
  Future<void> signingOut();

  @PATCH('persons/verify-account')
  Future verifyAccount(@Body() VerifyAccountRequest request);

  @PATCH('persons/reset-password')
  Future confirmResetPassword(@Body() ForgotRequest request);

  @POST('persons/forgot-password')
  Future sendResetPasswordEmail(@Body() ForgotEmailRequest request);

  @PATCH('persons/verification-email')
  Future sendOtp(@Body() SendOtpRequest request);

  @PATCH('/persons/update-password/{id}')
  Future<ProfileResponse> updatePassword(
      @Path('id') String id, @Body() UpdatePasswordRequest request);
}
