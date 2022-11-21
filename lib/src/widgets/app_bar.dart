import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/home/drawer_actions/settings/setting_page.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSize {
  AppBarWidget({
    Key? key,
    this.showNotificationDot = true,
    this.isCenterTitle = true,
  }) : super(key: key);

  final bool showNotificationDot;
  final bool isCenterTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white.withOpacity(0.1),
      leadingWidth: 50,

      centerTitle: isCenterTitle,
      // leading: IconButton(icon: Icon(Icons.arrow_back),),
      actions: [
        Stack(
          children: [
            Center(child: Image.asset(AppAssets.bellIcon)),
            if (showNotificationDot)
              Positioned(
                right: 2,
                top: -15,
                bottom: 0,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF1D681),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        GestureDetector(
          onTap: () {
            AppNavigation.to(context, const SettingPage());
          },
          child: Padding(
              padding: const EdgeInsets.only(right: 20, left: 10),
              child: CircleAvatar(
                radius: 15,
                child: Image.asset(AppAssets.user),
              )),
        ),
      ],
    );
  }

  final _appBar = AppBar();

  @override
  Widget get child => _appBar;

  @override
  Size get preferredSize => _appBar.preferredSize;
}
