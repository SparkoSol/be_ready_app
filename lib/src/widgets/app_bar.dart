import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/home/drawer_actions/settings/setting_page.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({
    Key? key,
    this.showNotificationDot = true,
    this.isCenterTitle = true,
    this.hasDrawer = false,
    this.parentScaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState>? parentScaffoldKey;
  final bool showNotificationDot;
  final bool isCenterTitle;
  final bool hasDrawer;
  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 50,

      centerTitle: widget.isCenterTitle,
      leading: widget.hasDrawer
          ? Padding(
              padding: const EdgeInsets.only(left: 25),
              child: GestureDetector(
                onTap: () {
                  if (widget.parentScaffoldKey != null) {
                    widget.parentScaffoldKey?.currentState?.openDrawer();
                  }
                },
                child: Image.asset(
                  AppAssets.drawerIcon,
                  width: 21,
                  height: 14,
                ),
              ),
            )
          : null,
      // IconButton(icon: Icon(Icons.arrow_back),),
      actions: [
        // Stack(
        //   children: [
        //     Center(child: Image.asset(AppAssets.bellIcon)),
        //     if (showNotificationDot)
        //       Positioned(
        //         right: 2,
        //         top: -15,
        //         bottom: 0,
        //         child: Container(
        //           height: 8,
        //           width: 8,
        //           decoration: const BoxDecoration(
        //             color: Color(0xFFF1D681),
        //             shape: BoxShape.circle,
        //           ),
        //         ),
        //       ),
        //   ],
        // ),
        GestureDetector(
          onTap: () async {
            print(AppData().readLastUser().image!);
            await AppNavigation.to(context, const SettingPage());
            setState(() {});
          },
          child: AppData().readLastUser().image == null
              ? Padding(
                  padding: const EdgeInsets.only(right: 20, left: 10),
                  child: CircleAvatar(
                    radius: 15,
                    child: Image.asset(AppAssets.defaultUser),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                    left: 10,
                    top: 10,
                    bottom: 10,
                  ),
                  child: AppNetworkImage(
                    url: AppData().readLastUser().image!,
                    borderRadius: 30,
                    width: 36,
                    height: 36,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ],
    );
  }
}
