import 'package:be_universe/src/components/home/drawer_actions/widget/drawer_action_title_widget.dart';
import 'package:be_universe/src/utils/const.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final _clause = List.generate(
    10,
    (i) => ClauseModel(
      clause: kLoremIpsum,
      clauseNumber: 'Clause ${i + 1}',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBarWidget(),
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: padding.top + 56,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DrawerActionTitleWidget(
                  title: 'Terms & Conditions',
                  bottomPadding: 8,
                ),
                Text(
                  'Last updated on 1/12/2021',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 58),
                for (int i = 0; i < _clause.length; i++) ...[
                  Text(
                    '${i + 1}. ${_clause[i].clauseNumber}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: Text(
                      _clause[i].clause,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
                AppButtonWidget(
                  onPressed: () async {},
                  title: 'Accept & Continue',
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ClauseModel {
  ClauseModel({required this.clause, required this.clauseNumber});

  final String clauseNumber;
  final String clause;
}
