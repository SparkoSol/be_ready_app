import 'package:be_ready_app/src/base/assets.dart';
import 'package:be_ready_app/src/base/nav.dart';
import 'package:be_ready_app/src/components/goals/explore.dart';
import 'package:be_ready_app/src/components/journey/journey_detail_page.dart';
import 'package:be_ready_app/src/components/main_menu/resources/resources_controller.dart';
import 'package:be_ready_app/src/widgets/app_bar.dart';
import 'package:be_ready_app/src/widgets/background_image_widget.dart';
import 'package:be_ready_app/src/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reusables/reusables.dart';

class ArticlesPage extends ControlledWidget<ResourceController> {
  const ArticlesPage({Key? key, required this.resourceController})
      : super(key: key, controller: resourceController);
  final ResourceController resourceController;

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> with ControlledStateMixin {
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
          child: widget.resourceController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 60),
                      child: GoalsPageTitle(text: 'Articles'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: ListView.builder(
                          controller: widget.resourceController.controller,
                          itemCount: widget.resourceController.dataList.length,
                          itemBuilder: (context, index) {
                            var data = widget.resourceController.dataList;

                            return GestureDetector(
                              onTap: () {
                                AppNavigation.to(context, const ExplorePage());
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
                                          'HR Ujjol',
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xffF0D781),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      lorem,
                                      maxLines: 3,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
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
    );
  }
}
