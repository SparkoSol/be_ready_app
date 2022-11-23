import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/auth/otp_page.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_text_span_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/or_widget.dart';
import 'package:be_ready_app/src/components/auth/widget/social_auth_button.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: padding.top + 56,
            bottom: padding.bottom,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(33, 22, 33, 28),
            child: Column(children: [
              const AuthTitleWidget(title: 'Sign up'),
              const SizedBox(height: 24),
              AppTextField(
                textEditingController: _fullNameController,
                prefix: Image.asset(AppAssets.profileIcon),
                hint: 'Full name',
              ),
              AppTextField(
                textEditingController: _emailController,
                keyboardType: TextInputType.emailAddress,
                prefix: Image.asset(AppAssets.messageIcon),
                hint: 'abc@email.com',
              ),
              AppPasswordField(
                textEditingController: _passwordController,
                prefix: Image.asset(AppAssets.passwordIcon),
                hint: 'Your password',
              ),
              AppPasswordField(
                textEditingController: _confirmPasswordController,
                prefix: Image.asset(AppAssets.passwordIcon),
                hint: 'Confirm password',
              ),
              AppButtonWidget(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  AppNavigation.to(context, const OtpPage());
                },
                title: 'SIGN UP',
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
                message: 'Already have an account?',
                buttonTitle: ' Sign in',
                action: () {
                  AppNavigation.pop(context);
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
