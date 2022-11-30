import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/main_menu/resources/widgets/article_widget.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({
    Key? key,
    required this.type,
  }) : super(key: key);

  final String type;

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
        widget.type,
        page.toString(),
        limit.toString(),
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
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 55,
            right: 55,
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: CustomListView<ResourceResponse>.simpler(
            listViewController: listController,
            baseColor: const Color(0xff2E2340),
            highLightColor: Colors.white12,
            shimmerWidget: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: const SizedBox(
                height: 70,
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            child: Image.asset(AppAssets.user),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            data.title,
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffF0D781),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff241B32),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Like',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                  size: 12,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
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
}
