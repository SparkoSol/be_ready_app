import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/main_menu/articles_page.dart';
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
            left: 30,
            right: 30,
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              const SliverToBoxAdapter(
                child: GoalsPageTitle(text: 'Resources'),
              ),
              const SliverToBoxAdapter(
                child: GoalsPageDescription(text: 'Absorb. Digest. Integrate.'),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 68)),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  childCount: _pageContent.length,
                  (context, i) {
                    final content = _pageContent[i];
                    return GestureDetector(
                      child: ResourceWidget(
                        isDifferentFromNormal: content['isDifferent'],
                        quantity: content['quantity'],
                        text: content['title'],
                      ),
                      onTap: () {
                        AppNavigation.to(
                          context,
                          i % 2 == 0 ? const ArticlesPage() : const VideoPage(),
                        );
                      },
                    );
                  },
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 26,
                  crossAxisSpacing: 17,
                  mainAxisExtent: 185,
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
