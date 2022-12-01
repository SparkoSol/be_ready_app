import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:reusables/mixins/form_state_mixin.dart';
import 'package:reusables/reusables.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> with FormStateMixin {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var _absorb = false;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return AbsorbPointer(
      absorbing: _absorb,
      child: Scaffold(
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
              padding: const EdgeInsets.fromLTRB(30, 24, 30, 28),
              child: Form(
                key: formKey,
                autovalidateMode: autovalidateMode,
                child: Column(children: [
                  const AuthTitleWidget(
                    title: 'Set new password',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(height: 24),
                  AppPasswordField(
                    textEditingController: _passwordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'New password',
                    validator: InputValidator.multiple([
                      InputValidator.required(message: 'Password is required')!,
                      InputValidator.length(
                        min: 5,
                        minMessage: 'Password must be 5 characters long',
                      )!,
                    ]),
                  ),
                  AppPasswordField(
                    textEditingController: _confirmPasswordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'Confirm password',
                    validator: (value) {
                      if (value != _passwordController.text.trim()) {
                        return 'Password not same';
                      }
                      return null;
                    },
                  ),
                  AppButtonWidget(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    onPressed: () async => submitter(),
                    title: 'SIGN UP',
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Future<void> onSubmit() async {}
}
