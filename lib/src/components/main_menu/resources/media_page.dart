import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe/src/widgets/media_widget.dart';
import 'package:be_universe/src/widgets/text.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class MediaPage extends StatefulWidget {
  const MediaPage({Key? key, required this.type})
      : super(
          key: key,
        );
  final String type;

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
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
    String title = widget.type;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 56,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GoalsPageTitle(text: title),
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
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 23),
                        child: MediaWidget(
                          resource: data,
                          path: AppAssets.backgroundImage,
                          type: widget.type,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
