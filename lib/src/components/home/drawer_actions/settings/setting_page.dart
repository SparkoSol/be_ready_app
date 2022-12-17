import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/auth/update_password_page.dart';
import 'package:be_universe/src/components/home/drawer_actions/settings/update_profile_page.dart';
import 'package:be_universe/src/components/payment_method/payment_method_page.dart';
import 'package:be_universe/src/widgets/app_network_image.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe_core/be_universe_core.dart';
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
      appBar: AppBar(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + 56),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(left: 52, right: 46),
              child: Column(children: [
                Text(
                  'Hello, ${AppData().readLastUser().name}!',
                  style: const TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 36),
                    child: AppData().readLastUser().image == null
                        ? Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Image.asset(
                                AppAssets.defaultUser,
                                fit: BoxFit.fill,
                                height: 111,
                                width: 111,
                              ),
                              Positioned(
                                right: 5,
                                child: GestureDetector(
                                  onTap: () async {
                                    await AppNavigation.to(
                                        context, const UpdateProfilePage());
                                    setState(() {});
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.indigo,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  left: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: AppNetworkImage(
                                  url: AppData().readLastUser().image!.fileUrl,
                                  borderRadius: 30,
                                  width: 111,
                                  height: 111,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => AppNavigation.to(
                                      context, const UpdateProfilePage()),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.indigo,
                                        shape: BoxShape.circle),
                                    padding: const EdgeInsets.all(5.0),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                // _ProfileDataContainer(
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       _getText(text: '+79183754623'),
                //       _getTrailing(text: 'Phone Number'),
                //     ],
                //   ),
                // ),
                _ProfileDataContainer(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _getText(text: AppData().readLastUser().email),
                      _getTrailing(text: 'Email'),
                    ],
                  ),
                ),
                if (AppData().readLastUser().loginVia == 'Email')
                  _ProfileDataContainer(
                    onTap: () =>
                        AppNavigation.to(context, const UpdatePasswordPage()),
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
                      Image.asset(
                        AppAssets.stripeIcon,
                        width: 50,
                        height: 27,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
    // Scaffold(
    //   extendBodyBehindAppBar: true,
    //   appBar: AppBarWidget(),
    //   body: BackgroundImageWidget(
    //     child: Padding(
    //       padding: EdgeInsets.only(top: padding.top + 56),
    //       child: SingleChildScrollView(
    //         physics: const BouncingScrollPhysics(),
    //         padding: const EdgeInsets.only(top: 166),
    //         child: Column(children: [
    //           const Text(
    //             'Hello, Laurie!',
    //             style: TextStyle(
    //               fontSize: 30,
    //               color: Colors.white,
    //             ),
    //           ),
    //           Padding(
    //             padding: const EdgeInsets.only(top: 20, bottom: 36),
    //             child: Image.asset(
    //               AppAssets.user,
    //               fit: BoxFit.fill,
    //               height: 111,
    //               width: 111,
    //             ),
    //           ),
    //           _ProfileDataContainer(
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 _getText(text: '+79183754623'),
    //                 _getTrailing(text: 'Phone Number'),
    //               ],
    //             ),
    //           ),
    //           _ProfileDataContainer(
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 _getText(text: 'address@address.com'),
    //                 _getTrailing(text: 'Email'),
    //               ],
    //             ),
    //           ),
    //           _ProfileDataContainer(
    //             onTap: () {},
    //             child: Row(children: [
    //               _getText(text: 'Change Password'),
    //             ]),
    //           ),
    //           _ProfileDataContainer(
    //             onTap: () => AppNavigation.to(
    //               context,
    //               const PaymentMethodPage(),
    //             ),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 _getText(text: 'Update Payment Method'),
    //                 Image.asset(AppAssets.stripeIcon, width: 62, height: 38),
    //               ],
    //             ),
    //           ),
    //         ]),
    //       ),
    //     ),
    //   ),
    // );
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
        margin: const EdgeInsets.only(bottom: 29),
        padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 29),
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

///OldCode Shahoor
// class _ProfileDataContainer extends StatelessWidget {
//   const _ProfileDataContainer({Key? key, required this.child, this.onTap})
//       : super(key: key);
//
//   final Widget child;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(24),
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.only(left: 52, right: 45, bottom: 29),
//         padding: const EdgeInsets.fromLTRB(31, 26, 24, 27),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           color: Colors.transparent,
//           shape: BoxShape.rectangle,
//           border: Border.all(
//             color: Colors.white.withOpacity(0.1),
//             width: 1.5,
//           ),
//         ),
//         child: child,
//       ),
//     );
//   }
// }
