import 'package:be_universe/src/components/home/drawer_actions/widget/drawer_action_title_widget.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/list_view/custom_list_view.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  State<TermsAndConditionsPage> createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late CustomListViewController<PoliciesResponse> listController;

  @override
  void initState() {
    super.initState();
    listController = CustomListViewController<PoliciesResponse>(
      listDataFunction: () => FaqApi().getPolicies(),
    );
  }

  late PoliciesResponse policiesResponse;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: const AppBarWidget(),
      body: SingleChildScrollView(
        child: BackgroundImageWidget(
          child: Padding(
            padding:
                EdgeInsets.only(top: padding.top + 56, left: 30, right: 30),
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
                const SizedBox(height: 30),
                Expanded(
                  child: CustomListView<PoliciesResponse>.simpler(
                    listViewController: listController,
                    baseColor: const Color(0xff2E2340),
                    highLightColor: Colors.white12,
                    shimmerCount: 3,
                    shimmerWidget: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const SizedBox(
                        height: 30,
                        width: double.infinity,
                      ),
                    ),
                    builder: (ctx, data) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            data.title ?? '',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, bottom: 30),
                            child: Text(
                              data.description ?? '',
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                AppButtonWidget(
                  onPressed: () async => Navigator.pop(context),
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
