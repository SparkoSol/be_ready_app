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
  late CustomListViewController<List<FaqResponse>> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<List<FaqResponse>>(
      dataFunction: () => FaqApi().getFaqs(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: padding.top + 56,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FAQ’s',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: CustomListView<List<FaqResponse>>.simpler(
                  listViewController: listController,
                  baseColor: const Color(0xff2E2340),
                  highLightColor: Colors.white12,
                  shimmerCount: 5,
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
                    return ListViewBuild(data: data);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListViewBuild extends StatefulWidget {
  const ListViewBuild({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<FaqResponse> data;

  @override
  State<ListViewBuild> createState() => _ListViewBuildState();
}

class _ListViewBuildState extends State<ListViewBuild> {
  final _expanded = <FaqResponse>[];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.data.length,
      padding: EdgeInsets.zero,
      itemBuilder: (BuildContext context, int index) {
        var faq = widget.data[index];
        var isExpanded = _expanded.contains(faq);
        return GestureDetector(
          onTap: () {
            if (isExpanded) {
              _expanded.remove(faq);
            } else {
              _expanded.add(faq);
            }
            setState(() {});
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
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
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            faq.title,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 6,
                    right: 6,
                    bottom: 25,
                  ),
                  child: Text(
                    faq.description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
