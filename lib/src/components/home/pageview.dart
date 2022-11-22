import 'package:be_ready_app/src/components/subscription/subscription_offers_page.dart';
import 'package:be_ready_app/src/components/subscription/subscription_page.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class PageViewWidget extends StatefulWidget {
  const PageViewWidget({Key? key}) : super(key: key);

  @override
  State<PageViewWidget> createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  var pages = [SubscriptionPage(), SubscriptionOffersPage()];
  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: PageView(
        controller: pageController,
        children: [SubscriptionPage(), SubscriptionOffersPage()],
      ),
    );
  }
}

class pageController extends ChangeNotifier {}
