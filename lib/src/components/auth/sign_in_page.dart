import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/modals/error_dialog.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/auth/reset_password_page.dart';
import 'package:be_ready_app/src/components/auth/sign_up_page.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/or_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/social_auth_button.dart';
import 'package:be_ready_app/src/components/home/home_page.dart';
import 'package:be_ready_app/src/services/auth_api.dart';
import 'package:be_ready_app/src/services/auth_service.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/custom_switch_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;

  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return AbsorbPointer(
      absorbing: _absorb,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BackgroundImageWidget(
          child: Padding(
            padding: EdgeInsets.only(top: padding.top, bottom: padding.bottom),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(33, 58, 33, 28),
              child: Form(
                key: _formKey,
                autovalidateMode: _autoValidateMode,
                child: Column(
                  children: [
                    const AuthTitleWidget(title: 'Sign in'),
                    const SizedBox(height: 24),
                    AppTextField(
                      textEditingController: _emailController,
                      prefix: Image.asset(AppAssets.messageIcon),
                      hint: 'abc@email.com',
                      keyboardType: TextInputType.emailAddress,
                      validator:
                          InputValidator.email(message: 'Email is required'),
                    ),
                    AppPasswordField(
                      textEditingController: _passwordController,
                      prefix: Image.asset(AppAssets.passwordIcon),
                      hint: 'Your password',
                      validator: InputValidator.required(
                          message: 'Password is required'),
                    ),
                    Row(children: [
                      SwitchWidget(
                        value: _rememberMe,
                        callback: (_) => _rememberMe = _,
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          'Remember Me',
                          style: GoogleFonts.poppins(
                            color: Colors.white.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ]),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            minimumSize: Size.zero,
                            visualDensity: const VisualDensity(
                              vertical: -4,
                              horizontal: -4,
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            AppNavigation.to(
                                context, const ResetPasswordPage());
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(),
                          ),
                        ),
                      ),
                    ),
                    AppButtonWidget(
                      onPressed: submit,
                      before: () => setState(() => _absorb = true),
                      after: () => setState(() => _absorb = false),
                      title: 'SIGN IN',
                    ),
                    const OrWidget(),
                    SocialAuthButton(
                      onTap: googleSignIn,
                      platformImage: AppAssets.google,
                      platformName: 'Google',
                    ),
                    SocialAuthButton(
                      onTap: facebookSignIn,
                      platformImage: AppAssets.facebook,
                      platformName: 'Facebook',
                    ),
                    AuthTextSpanWidget(
                      message: 'Don’t have an account?',
                      buttonTitle: ' Sign up',
                      action: () {
                        AppNavigation.to(context, const SignUpPage());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit() async {
    if (!_formKey.currentState!.validate()) {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }

    try {
      await AuthenticationService().signIn(
        UserSignInRequest(
          username: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
      if (!mounted) return;
      FocusScope.of(context).unfocus();
      AppNavigation.navigateRemoveUntil(context, const HomePage());
    } catch (_) {
      rethrow;
    }
  }

  // Future<void> signinigIn() async {
  //   try {
  //     await AuthenticationService().signIn(
  //       UserSignInRequest(
  //         username: _emailController.text.trim(),
  //         password: _passwordController.text.trim(),
  //       ),
  //     );
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> googleSignIn() async {
    try {
      final response = await AuthService.signInWithGoogle();
      final token = await response.user!.getIdToken();
      await Awaiter.process(
          future: AuthenticationService().socialSignIn(SocialSignInRequest(
              username: response.user?.email ?? 'none',
              idToken: token,
              name: response.user?.displayName ?? 'default mail',
              email: response.user?.email ?? 'default mail',
              image: response.user?.photoURL ?? '',
              loginVia: 'Google')),
          context: context,
          arguments: 'saving...');
      if (!mounted) return;
      AppNavigation.navigateRemoveUntil(context, const HomePage());
    } catch (e) {
      ErrorDialog(error: e).show(context);
    }
  }

  Future<void> facebookSignIn() async {
    try {
      final response = await AuthService.signInWithFacebook();
      final token = await response.user!.getIdToken();
      await Awaiter.process(
          future: AuthenticationService().socialSignIn(SocialSignInRequest(
              username: response.user?.email ?? 'none',
              idToken: token,
              name: response.user?.displayName ?? 'default mail',
              email: response.user?.email ?? 'default mail',
              image: response.user?.photoURL ?? '',
              loginVia: 'Facebook')),
          context: context,
          arguments: 'saving...');
      if (!mounted) return;
      AppNavigation.navigateRemoveUntil(context, const HomePage());
    } catch (e) {
      ErrorDialog(error: e).show(context);
    }
  }
}
