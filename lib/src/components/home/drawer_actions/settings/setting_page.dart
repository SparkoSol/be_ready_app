import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/payment_method/payment_method_page.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + 56),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 166),
            child: Column(children: [
              const Text(
                'Hello, Laurie!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 36),
                child: Image.asset(
                  AppAssets.user,
                  fit: BoxFit.fill,
                  height: 111,
                  width: 111,
                ),
              ),
              _ProfileDataContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: '+79183754623'),
                    _getTrailing(text: 'Phone Number'),
                  ],
                ),
              ),
              _ProfileDataContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: 'address@address.com'),
                    _getTrailing(text: 'Email'),
                  ],
                ),
              ),
              _ProfileDataContainer(
                onTap: () {},
                child: Row(children: [
                  _getText(text: 'Change Password'),
                ]),
              ),
              _ProfileDataContainer(
                onTap: () => AppNavigation.to(
                  context,
                  const PaymentMethodPage(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: 'Update Payment Method'),
                    Image.asset(AppAssets.stripeIcon, width: 62, height: 38),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
    Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + 56),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 166),
            child: Column(children: [
              const Text(
                'Hello, Laurie!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 36),
                child: Image.asset(
                  AppAssets.user,
                  fit: BoxFit.fill,
                  height: 111,
                  width: 111,
                ),
              ),
              _ProfileDataContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: '+79183754623'),
                    _getTrailing(text: 'Phone Number'),
                  ],
                ),
              ),
              _ProfileDataContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: 'address@address.com'),
                    _getTrailing(text: 'Email'),
                  ],
                ),
              ),
              _ProfileDataContainer(
                onTap: () {},
                child: Row(children: [
                  _getText(text: 'Change Password'),
                ]),
              ),
              _ProfileDataContainer(
                onTap: () => AppNavigation.to(
                  context,
                  const PaymentMethodPage(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _getText(text: 'Update Payment Method'),
                    Image.asset(AppAssets.stripeIcon, width: 62, height: 38),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _getTrailing({required String text}) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 12,
        color: Colors.white.withOpacity(0.5),
      ),
    );
  }

  Widget _getText({required String text}) {
    return Expanded(
      child: Text(text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
    );
  }
}

class _ProfileDataContainer extends StatelessWidget {
  const _ProfileDataContainer({Key? key, required this.child, this.onTap})
      : super(key: key);

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 52, right: 45, bottom: 29),
        padding: const EdgeInsets.fromLTRB(31, 26, 24, 27),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1.5,
          ),
        ),
        child: child,
      ),
    );
  }
}
