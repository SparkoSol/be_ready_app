import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/video_page.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/resources_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatelessWidget {
  ResourcePage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> _pageContent = [
    {'title': 'Articles', 'quantity': 200, 'isDifferent': true},
    {'title': 'Videos', 'quantity': 180, 'isDifferent': false},
    {'title': 'Audios', 'quantity': 100, 'isDifferent': false},
    {'title': 'Books', 'quantity': 90, 'isDifferent': true},
    {'title': 'Podcasts', 'quantity': 50, 'isDifferent': false},
    {'title': 'Quotes', 'quantity': 190, 'isDifferent': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(),
        body: BackgroundImageWidget(
          child: Padding(
            padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
                top: MediaQuery.of(context).viewPadding.top + 56),
            child: CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: GoalsPageTitle(text: 'Resources'),
                ),
                const SliverToBoxAdapter(
                  child:
                      GoalsPageDescription(text: 'Absorb. Digest. Integrate.'),
                ),
                SliverPadding(padding: EdgeInsets.only(bottom: 20)),
                SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => GestureDetector(
                            child: ResourceWidget(
                              quantity: 525,
                              text: 'Articelss',
                              isDifferentFromNormal: false,
                            ),
                            onTap: () {
                              AppNavigation.to(context, VideoPage());
                            },
                          )),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    // mainAxisExtent: 200,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
