// import 'package:be_universe/src/components/subscription/offers/subscription_offers_page.dart';
// import 'package:be_universe/src/components/subscription/subscription_page.dart';
// import 'package:be_universe/src/widgets/app_bar.dart';
// import 'package:flutter/material.dart';
//
// class PageViewWidget extends StatefulWidget {
//   const PageViewWidget({Key? key}) : super(key: key);
//
//   @override
//   State<PageViewWidget> createState() => _PageViewWidgetState();
// }
//
// class _PageViewWidgetState extends State<PageViewWidget> {
//   var pages = [const SubscriptionPage(), SubscriptionOffersPage()];
//   PageController pageController = PageController(
//     initialPage: 0,
//     keepPage: true,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBarWidget(),
//       body: PageView(
//         controller: pageController,
//         children: [const SubscriptionPage(), SubscriptionOffersPage()],
//       ),
//     );
//   }
// }
//
// class pageController extends ChangeNotifier {}
