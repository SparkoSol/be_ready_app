import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_ready_app/src/widgets/list_view/custom_list_view.dart';
import 'package:be_ready_app/src/widgets/media_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
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
        widget.type,
        page.toString(),
        limit.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    late String title;
    switch (widget.type) {
      case 'Video':
        title = 'Videos';
        break;
      case 'Book':
        title = 'Books';
        break;
      case 'Audio':
        title = 'Audios';
        break;
      case 'Podcast':
        title = 'Podcasts';
        break;
      case 'Quote':
        title = 'Quotes';
        break;
    }

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
                  padding: const EdgeInsets.only(bottom: 60),
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