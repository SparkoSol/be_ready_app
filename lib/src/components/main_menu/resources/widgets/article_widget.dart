import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailWidget extends StatefulWidget {
  final String title;
  final String description;

  const ArticleDetailWidget(
      {Key? key, required this.description, required this.title})
      : super(key: key);

  @override
  State<ArticleDetailWidget> createState() => _ArticleDetailWidgetState();
}

class _ArticleDetailWidgetState extends State<ArticleDetailWidget> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);

    print(widget.description);

    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBarWidget(),
        body: BackgroundImageWidget(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 20,
                      top: media.viewPadding.top + 60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.title,
                        style: GoogleFonts.oswald(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(height: 15),
                      Html(
                        style: {
                          "*": Style(color: Colors.white),
                          "li": Style(
                            color: Colors.white,
                          ),
                          // "ul li::before": Style(
                          //   color: Colors.red,
                          //   fontWeight: FontWeight.bold,
                          //   display: Display.INLINE_BLOCK,
                          //   width: 1,
                          //   margin: const EdgeInsets.only(left: 1),
                          // ),
                        },
                        data: widget.description,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
