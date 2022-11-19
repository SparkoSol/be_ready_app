import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();

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
            padding: const EdgeInsets.fromLTRB(33, 24, 33, 28),
            child: Column(children: [
              const AuthTitleWidget(
                title: 'Reset Password',
                fontWeight: FontWeight.w400,
              ),
              const SizedBox(height: 12),
              Text(
                'Please enter your email address to request a password reset',
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
              ),
              const SizedBox(height: 30),
              AppTextField(
                textEditingController: _emailController,
                prefix: Image.asset(AppAssets.messageIcon),
                hint: 'abc@email.com',
                bottomPadding: 44,
              ),
              AppButtonWidget(
                onPressed: () {},
                title: 'SEND',
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
