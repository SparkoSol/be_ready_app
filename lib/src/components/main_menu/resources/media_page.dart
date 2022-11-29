import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resources_controller.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/media_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class MediaPage extends ControlledWidget<ResourceController> {
  const MediaPage({Key? key, required this.resourceController})
      : super(key: key, controller: resourceController);
  final ResourceController resourceController;

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    late String title;
    switch (widget.resourceController.type) {
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
          child: widget.resourceController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 60),
                        child: GoalsPageTitle(text: title),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                            controller: widget.resourceController.controller,
                            itemCount:
                                widget.resourceController.dataList.length,
                            itemBuilder: (context, index) {
                              var data = widget.resourceController.dataList;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 23),
                                child: MediaWidget(
                                  index: index,
                                  path: AppAssets.backgroundImage,
                                  controller: widget.resourceController,
                                ),
                              );
                            }),
                      ),
                      if (widget.resourceController.isLoadingMore)
                        const Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
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
