import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resources_controller.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:be_ready_app/src/widgets/video_widget.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';

class VideoPage extends ControlledWidget<ResourceController> {
  const VideoPage({Key? key, required this.resourceController})
      : super(key: key, controller: resourceController);
  final ResourceController resourceController;
  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: GoalsPageTitle(text: 'Videos'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ListView.builder(
                            controller: widget.resourceController.controller,
                            itemCount:
                                widget.resourceController.dataList.length,
                            itemBuilder: (context, index) {
                              var data = widget.resourceController.dataList;

                              return const Padding(
                                padding: EdgeInsets.only(bottom: 23),
                                child: VideoWidget(
                                    path: AppAssets.backgroundImage),
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
