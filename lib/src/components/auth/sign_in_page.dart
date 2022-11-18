import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/auth/auth_title_widget.dart';
import 'package:be_ready_app/src/components/home/home_page.dart';
import 'package:be_ready_app/src/widgets/app_button_widget.dart';
import 'package:be_ready_app/src/widgets/app_text_field.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/cupertino.dart';
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  onPressed: () => AppNavigation.to(context, const HomePage()),
                  child: Stack(
                    children: [
                      const Center(
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFDA8B6D),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(-2, -2),
                                // color: const Color(0xFFDA8B6D).withOpacity(0.1),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.arrow_forward_sharp),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    Key? key,
    required this.value,
    required this.callback,
  }) : super(key: key);

  final bool value;
  final void Function(bool) callback;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _value,
      onChanged: (_) {
        _value = _;
        widget.callback(_value);
        setState(() {});
      },
    );
  }
}
