import 'package:be_ready_app/src/base/modals/error_dialog.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/main_menu/articles_page.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resources_controller.dart';
import 'package:be_ready_app/src/components/video_page.dart';
import 'package:be_ready_app/src/services/exception_service.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/resources_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  final List<Map<String, dynamic>> _pageContent = [
    {
      'title': 'Articles',
      'quantity': 200,
      'isDifferent': true,
      'type': 'Article'
    },
    {'title': 'Videos', 'quantity': 180, 'isDifferent': false, 'type': 'Video'},
    {'title': 'Audios', 'quantity': 100, 'isDifferent': false, 'type': 'Audio'},
    {'title': 'Books', 'quantity': 90, 'isDifferent': true, 'type': 'Book'},
    {
      'title': 'Podcasts',
      'quantity': 50,
      'isDifferent': false,
      'type': 'Podcast'
    },
    {'title': 'Quotes', 'quantity': 190, 'isDifferent': true, 'type': 'Quote'},
  ];

  late ResourceCountResponse resources;
  int audioCount = 0;
  int articleCount = 0;
  int videoCount = 0;
  int booksCount = 0;
  int podcastsCount = 0;
  int quotesCount = 0;
  List<int> resourcesCount = [];
  bool loading = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getResources());
    super.initState();
  }

  Future<void> getResources() async {
    try {
      resources = await Awaiter.process(
          future: ResourcesApi().getResourcesCount(),
          context: context,
          arguments: 'loading ...');

      videoCount = resources.videos ?? 0;
      articleCount = resources.articles ?? 0;
      audioCount = resources.audios ?? 0;
      booksCount = resources.books ?? 0;
      podcastsCount = resources.podcasts ?? 0;
      quotesCount = resources.quotes ?? 0;

      resourcesCount = [
        articleCount,
        videoCount,
        audioCount,
        booksCount,
        podcastsCount,
        quotesCount
      ];
      loading = false;
      setState(() {});
    } catch (e) {
      ErrorDialog(error: DialogError.withDioError(e)).show(context);
    }
  }

  // Future<void> getSelectedResource(String type) async {
  //   try {
  //     final resource = await ResourcesApi().getPaginatedResource('Video', '3', '3');
  //     // print(resource!.length??0);
  //   } catch (e) {
  //     ErrorDialog(error: e).show(context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                ),
              )
            : Padding(
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
                      child: GoalsPageDescription(
                          text: 'Absorb. Digest. Integrate.'),
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
                              quantity: resourcesCount[i],
                              text: content['title'],
                            ),
                            onTap: () async {
                              //    await getSelectedResource(content['type']);
                              if (mounted) {
                                dynamic page;
                                switch (content['type']) {
                                  case 'Article':
                                    page = ArticlesPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );
                                    break;
                                  case 'Book':
                                    page = ArticlesPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );
                                    break;
                                  case 'Podcast':
                                    page = ArticlesPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );

                                    break;
                                  case 'Audio':
                                    page = ArticlesPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );

                                    break;
                                  case 'Video':
                                    page = VideoPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );

                                    break;
                                  case 'Quote':
                                    page = ArticlesPage(
                                      resourceController: ResourceController(
                                          type: content['type']),
                                    );

                                    break;
                                }
                                AppNavigation.to(context, page);
                              }
                            },
                          );
                        },
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
