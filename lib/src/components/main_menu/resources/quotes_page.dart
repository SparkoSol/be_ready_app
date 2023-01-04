import 'package:be_universe/src/base/modals/dialogs/error_dialog.dart';
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
  const QuotesPage({Key? key, required this.type, required this.count})
      : super(
          key: key,
        );
  final String type;
  final int count;

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
      appBar: const AppBarWidget(),
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
                  shimmerCount: widget.count,
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
