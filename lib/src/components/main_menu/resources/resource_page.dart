import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_view.dart';
import 'package:be_ready_app/src/widgets/resources_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class ResourcePage extends StatefulWidget {
  const ResourcePage({Key? key}) : super(key: key);

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  final _content = <String, int>{};

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
            30,
            MediaQuery.of(context).padding.top + 56,
            30,
            0,
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
                shimmerWidget: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const SizedBox(
                    height: 150,
                    width: double.infinity,
                  ),
                ),
                builder: (ctx, data) {
                  _content['Article'] = data.articles ?? 0;
                  _content['videos'] = data.videos ?? 0;
                  _content['Audios'] = data.audios ?? 0;
                  _content['Books'] = data.books ?? 0;
                  _content['Podcasts'] = data.podcasts ?? 0;
                  _content['Quotes'] = data.quotes ?? 0;
                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: _content.length,
                      (context, i) {
                        final item = _content.entries.elementAt(i);
                        return GestureDetector(
                          child: ResourceWidget(
                            isDifferentFromNormal: i == 5 ? true : i % 3 == 0,
                            quantity: item.value,
                            text: item.key,
                          ),
                          onTap: () async {
                            //    await getSelectedResource(content['type']);
                            // if (mounted) {
                            //   dynamic page;
                            //   switch (content['type']) {
                            //     case 'Article':
                            //       page = ArticlesPage(
                            //         type: content['type'],
                            //       );
                            //       break;
                            //     case 'Book':
                            //       page = MediaPage(type: content['type']);
                            //       break;
                            //     case 'Podcast':
                            //       page = MediaPage(type: content['type']);
                            //
                            //       break;
                            //     case 'Audio':
                            //       page = MediaPage(type: content['type']);
                            //
                            //       break;
                            //     case 'Videos':
                            //       page = MediaPage(type: 'Videos);
                            //
                            //       break;
                            //     case 'Quote':
                            //       page = QuotesPage(
                            //         type: content['type'],
                            //       );
                            //
                            //       break;
                            //   }
                            //   AppNavigation.to(context, page);
                            // }
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