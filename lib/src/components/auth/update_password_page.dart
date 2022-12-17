import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/components/auth/widget/auth_title_widget.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  var _absorb = false;

  final formKey = GlobalKey<FormState>();
  var autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return AbsorbPointer(
      absorbing: _absorb,
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
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
                child: Column(children: [
                  const AuthTitleWidget(
                    title: 'Update Password',
                    fontWeight: FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  AppPasswordField(
                    textEditingController: _oldPasswordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'Your old password',
                    validator: InputValidator.multiple([
                      InputValidator.required(message: 'Password is required')!,
                      InputValidator.length(
                        min: 5,
                        minMessage: 'Password must be 5 characters long',
                      )!,
                    ]),
                  ),
                  AppPasswordField(
                    textEditingController: _newPasswordController,
                    prefix: Image.asset(AppAssets.passwordIcon),
                    hint: 'Your new password',
                    validator: InputValidator.multiple([
                      InputValidator.required(message: 'Password is required')!,
                      InputValidator.length(
                        min: 5,
                        minMessage: 'Password must be 5 characters long',
                      )!,
                    ]),
                  ),
                  const SizedBox(height: 20),
                  AppButtonWidget(
                    before: () => setState(() => _absorb = true),
                    after: () => setState(() => _absorb = false),
                    onPressed: onSubmit,
                    title: 'SEND',
                  ),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmit() async {
    if (!formKey.currentState!.validate()) {
      autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    if (_newPasswordController.text.trim() ==
        _oldPasswordController.text.trim()) {
      $showSnackBar(context, 'Old & New Password Can not Be Same');
      return;
    }
    try {
      var response = await AuthenticationApi().updatePassword(
          AppData().readLastUser().userid,
          UpdatePasswordRequest(
              newPassword: _newPasswordController.text.trim(),
              oldPassword: _oldPasswordController.text.trim()));
      await AppData().saveUser(response);
      if (!mounted) return;
      $showSnackBar(context, 'Password updated successfully');
      Navigator.pop(context);
    } catch (e) {
      if (e is DioError && ((e.response?.statusCode ?? 0) == 404)) {
        throw 'Incorrect Password, old password did not match';
      }

      rethrow;
    }
  }
}
