import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/main_menu/resources/articles_page.dart';
import 'package:be_universe/src/components/main_menu/resources/media_page.dart';
import 'package:be_universe/src/components/main_menu/resources/quotes_page.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/resources_widget.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  final _content = <ResourcesCategories, int>{};

  // final List<Map<String, dynamic>> _pageContent = [
  //   {
  //     'title': 'Articles',
  //     'quantity': 200,
  //     'isDifferent': true,
  //     'type': 'Article'
  //   },
  //   {'title': 'Videos', 'quantity': 180, 'isDifferent': false, 'type': 'Video'},
  //   {'title': 'Audios', 'quantity': 100, 'isDifferent': false, 'type': 'Audio'},
  //   {'title': 'Books', 'quantity': 90, 'isDifferent': true, 'type': 'Book'},
  //   {
  //     'title': 'Podcasts',
  //     'quantity': 50,
  //     'isDifferent': false,
  //     'type': 'Podcast'
  //   },
  //   {'title': 'Quotes', 'quantity': 190, 'isDifferent': true, 'type': 'Quote'},
  // ];

  // late ResourceCountResponse resources;
  // int audioCount = 0;
  // int articleCount = 0;
  // int videoCount = 0;
  // int booksCount = 0;
  // int podcastsCount = 0;
  // int quotesCount = 0;
  // List<int> resourcesCount = [];
  // bool loading = true;
  late CustomListViewController<ResourceCountResponse> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<ResourceCountResponse>(
      dataFunction: () => ResourcesApi().getResourcesCount(),
    );
  }

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) => getResources());
  //   super.initState();
  // }

  // Future<void> getResources() async {
  //   try {
  //     // resources = await ResourcesApi().getResourcesCount();
  //
  //     videoCount = resources.videos ?? 0;
  //     articleCount = resources.articles ?? 0;
  //     audioCount = resources.audios ?? 0;
  //     booksCount = resources.books ?? 0;
  //     podcastsCount = resources.podcasts ?? 0;
  //     quotesCount = resources.quotes ?? 0;
  //
  //     resourcesCount = [
  //       articleCount,
  //       videoCount,
  //       audioCount,
  //       booksCount,
  //       podcastsCount,
  //       quotesCount
  //     ];
  //     loading = false;
  //     setState(() {});
  //   } catch (e) {
  //     ErrorDialog(error: DioException.withDioError(e)).show(context);
  //   }
  // }

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
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            54,
            MediaQuery.of(context).padding.top + 56,
            63,
            60,
          ),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: GoalsPageTitle(text: 'Resources'),
              ),
              const SliverToBoxAdapter(
                child: GoalsPageDescription(text: 'Absorb. Digest. Integrate.'),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 68)),
              CustomListView<ResourceCountResponse>.sliver(
                listViewController: listController,
                // baseColor: const Color(0xff2E2340),
                // highLightColor: Colors.white12,
                isGridShimmer: true,
                // shimmerWidget: Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   child: const SizedBox(
                //     height: 150,
                //     width: double.infinity,
                //   ),
                // ),
                builder: (ctx, data) {
                  _content[ResourcesCategories.articles] = data.articles ?? 0;
                  _content[ResourcesCategories.videos] = data.videos ?? 0;
                  _content[ResourcesCategories.audios] = data.audios ?? 0;
                  _content[ResourcesCategories.books] = data.books ?? 0;
                  _content[ResourcesCategories.podcasts] = data.podcasts ?? 0;
                  _content[ResourcesCategories.quotes] = data.quotes ?? 0;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: ResourcesCategories.values.length,
                      (context, i) {
                        final item = _content.entries.elementAt(i);
                        return GestureDetector(
                          child: ResourceWidget(
                            isBoth: true,
                            isDifferentFromNormal: true,
                            quantity: item.value,
                            text: item.key.category,
                          ),
                          onTap: () async {
                            if (mounted) {
                              dynamic page;
                              switch (item.key) {
                                case ResourcesCategories.videos:
                                  page = MediaPage(
                                    type: item.key.category,
                                    count: item.value,
                                  );
                                  break;
                                case ResourcesCategories.audios:
                                  page = MediaPage(
                                    type: item.key.category,
                                    count: item.value,
                                  );

                                  break;
                                case ResourcesCategories.quotes:
                                  page = QuotesPage(
                                    type: item.key.category,
                                    count: item.value,
                                  );
                                  break;
                                case ResourcesCategories.podcasts:
                                  page = MediaPage(
                                    type: item.key.category,
                                    count: item.value,
                                  );

                                  break;
                                case ResourcesCategories.articles:
                                  page = ArticlesPage(
                                    count: item.value,
                                  );
                                  break;
                                case ResourcesCategories.books:
                                  page = MediaPage(
                                    type: item.key.category,
                                    count: item.value,
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ResourcesCategories {
  videos('Videos'),
  audios('Audios'),
  quotes('Quotes'),
  podcasts('Podcasts'),
  articles('Articles'),
  books('Books');

  const ResourcesCategories(this.category);

  final String category;
}
