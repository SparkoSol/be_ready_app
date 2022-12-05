import 'package:be_universe/src/utils/const.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  late CustomListViewController<FaqResponse> faqController;

  @override
  void initState() {
    super.initState();
    faqController = CustomListViewController<FaqResponse>(
      listDataFunction: () => FaqApi().getAllFaqs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(top: padding.top + 56, left: 20, right: 20),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Text(
                  'FAQ’s',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 10,
                ),
              ),
              CustomListView<FaqResponse>.sliver(
                listViewController: faqController,
                baseColor: const Color(0xff2E2340),
                shimmerCount: 1,
                highLightColor: Colors.white12,
                shimmerWidget: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const SizedBox(
                    height: 40,
                    width: double.infinity,
                  ),
                ),
                builder: (ctx, data) {
                  // final _isExpanded = List.generate(data., (i) => false);

                  return GestureDetector(
                    onTap: () {
                      // _isExpanded[i] = !_isExpanded[i];
                      setState(() {});
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.only(
                        left: 27,
                        right: 15,
                        top: 16,
                        bottom: 16,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2E2340),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: Column(children: [
                        Row(
                          children: [
                            Text(
                              data.title,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            // const Spacer(),
                            // Icon(
                            //   _isExpanded[i]
                            //       ? Icons.expand_less
                            //       : Icons.expand_more,
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                        // if (_isExpanded[i]) ...[
                        //   Padding(
                        //     padding: const EdgeInsets.only(
                        //       left: 6,
                        //       right: 6,
                        //       bottom: 25,
                        //     ),
                        //     child: Text(
                        //       kLoremIpsum,
                        //       style: GoogleFonts.poppins(
                        //         fontSize: 13,
                        //         color: Colors.white.withOpacity(0.6),
                        //       ),
                        //     ),
                        //   )
                        // ]
                      ]),
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
