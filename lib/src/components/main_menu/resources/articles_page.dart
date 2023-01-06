import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
import 'package:be_universe/src/base/nav.dart';
import 'package:be_universe/src/components/main_menu/resources/widgets/article_widget.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/utils/awaiter.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({
    Key? key,
    this.isBeConnected = false,
    this.count,
  }) : super(key: key);

  final bool isBeConnected;
  final int? count;

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  // late PaginatedListViewController<ResourceResponse, ResourceResponse>
  //     listController;

  late CustomListViewController<ResourceResponse> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<ResourceResponse>(
      paginatedFunction: (int page, int limit) =>
          ResourcesApi().getPaginatedResource(
        page.toString(),
        limit.toString(),
        liked: widget.isBeConnected ? 'true' : null,
        type: 'Article',
        userId: AppData().readLastUser().userid,
      ),
    );
    // listController = PaginatedListViewController(
    //   dataFunction: (page, limit) => ResourcesApi().getPaginatedResource(
    //       type, page.toString(), limit.toString()),
    //   limit: limit,
    //   parseData: parseData,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(52, 0, 46, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!widget.isBeConnected)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: GoalsPageTitle(text: 'Articles'),
                  )
                else ...[
                  const GoalsPageTitle(text: 'Be Connected '),
                  const SizedBox(height: 6),
                  const GoalsPageDescription(
                    text: 'Aware. Acknowledge. Accept.',
                  ),
                  const SizedBox(height: 36),
                ],
                Expanded(
                  child: CustomListView<ResourceResponse>.simpler(
                    listViewController: listController,
                    baseColor: const Color(0xff2E2340),
                    highLightColor: Colors.white12,
                    shimmerCount: widget.count,
                    shimmerWidget: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const SizedBox(
                        height: 20,
                        width: double.infinity,
                      ),
                    ),
                    builder: (ctx, data) {
                      return GestureDetector(
                        onTap: () {
                          AppNavigation.to(
                            context,
                            ArticleDetailWidget(
                              title: data.title,
                              description: data.description,
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 31),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xff2E2340),
                          ),
                          child: Column(children: [
                            Row(children: [
                              if (data.thumbnail.isNotEmpty)
                                CircleAvatar(
                                  radius: 12,
                                  child: Image.network(data.thumbnail),
                                ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  data.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xffF0D781),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => like(data),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xff241B32),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8,
                                  ),
                                  child: Row(children: [
                                    Text(
                                      data.liked == true ? 'Unlike' : 'Like',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      Icons.favorite,
                                      color: data.liked == true
                                          ? Colors.red
                                          : Colors.white,
                                      size: 12,
                                    )
                                  ]),
                                ),
                              )
                            ]),
                          ]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // child: widget.resourceController.isLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(
          //           color: Colors.indigo,
          //         ),
          //       )
          //     : Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Padding(
          //             padding: const EdgeInsets.only(bottom: 60),
          //             child: GoalsPageTitle(text: widget.controller.type),
          //           ),
          //           Expanded(
          //             child: ListView.builder(
          //                 controller: widget.resourceController.controller,
          //                 itemCount: widget.resourceController.dataList.length,
          //                 itemBuilder: (context, index) {
          //                   var data =
          //                       widget.resourceController.dataList[index];
          //
          //                 }),
          //           ),
          //           if (widget.resourceController.isLoadingMore)
          //             const Center(
          //               child: CircularProgressIndicator(
          //                 color: Colors.indigo,
          //               ),
          //             ),
          //         ],
          //       ),
        ),
      ),
    );
  }

  Future<void> like(ResourceResponse resource) async {
    try {
      await Awaiter.process(
        future: ResourcesApi()
            .likeResource(AppData().readLastUser().userid, resource.id),
        context: context,
        arguments: 'saving',
      );
      if (widget.isBeConnected) {
        await listController.refresh();
      } else {
        resource.liked = !(resource.liked ?? false);
        setState(() {});
      }
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e));
    }
  }
}
