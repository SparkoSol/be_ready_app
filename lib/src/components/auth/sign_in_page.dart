import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/auth/sign_up_page.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_button_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/or_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/social_auth_button.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/custom_switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: padding.top,
            bottom: padding.bottom,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(33, 58, 33, 28),
            child: Column(
              children: [
                const AuthTitleWidget(title: 'Sign in'),
                const SizedBox(height: 24),
                AppTextField(
                  textEditingController: _emailController,
                  prefix: Image.asset(AppAssets.messageIcon),
                  hint: 'abc@email.com',
                ),
                AppPasswordField(
                  textEditingController: _passwordController,
                  prefix: Image.asset(AppAssets.passwordIcon),
                  hint: 'Your password',
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(children: [
                    SwitchWidget(
                      value: _rememberMe,
                      callback: (_) => _rememberMe = _,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Remember Me',
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.poppins(),
                      ),
                    ),
                  ]),
                ),
                AppButtonWidget(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: const AuthButtonTitleWidget(title: 'SIGN IN'),
                ),
                const OrWidget(),
                SocialAuthButton(
                  onTap: () {},
                  platformImage: AppAssets.google,
                  platformName: 'Google',
                ),
                SocialAuthButton(
                  onTap: () {},
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
    );
  }
}
