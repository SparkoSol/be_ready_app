import 'package:be_universe/src/base/modals/error_dialog.dart';
import 'package:be_universe/src/utils/dio_exception.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({
    Key? key,
    required this.type,
  }) : super(
          key: key,
        );
  final String type;

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  late CustomListViewController<ResourceResponse> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<ResourceResponse>(
      paginatedFunction: (int page, int limit) =>
          ResourcesApi().getPaginatedResource(
        page.toString(),
        limit.toString(),
        userId: AppData().readLastUser().userid,
        type: widget.type.substring(0, widget.type.length - 1),
        // AppData().readLastUser().userid,
      ),
    );
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GoalsPageTitle(text: widget.type),
              ),
              Expanded(
                child: CustomListView<ResourceResponse>.simpler(
                  listViewController: listController,
                  baseColor: const Color(0xff2E2340),
                  highLightColor: Colors.white12,
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
                    return Container(
                      margin: const EdgeInsets.only(bottom: 31),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xff2E2340),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '''" ${data.description} "''',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(children: [
                                Text(
                                  'Author:',
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  data.authorName!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                )
                              ]),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => like(data),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xff241B32),
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Row(
                                    children: [
                                      Text(
                                        data.liked == true ? 'Unlike' : 'Like',
                                        style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size: 12,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> like(ResourceResponse resource) async {
    try {
      print(resource.id);
      await Awaiter.process(
          future: ResourcesApi()
              .likeResource(AppData().readLastUser().userid, resource.id),
          context: context,
          arguments: 'saving');

      resource.liked = !(resource.liked ?? false);
      setState(() {});
    } catch (e) {
      ErrorDialog(error: DioException.withDioError(e));
    }
  }
}
