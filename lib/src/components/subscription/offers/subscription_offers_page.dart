import 'package:be_universe/src/components/subscription/offers/sub_config.dart';
import 'package:be_universe/src/base/modals/app_snackbar.dart';
import 'package:be_universe/src/components/subscription/offers/product_widget.dart';
import 'package:be_universe/src/services/purchase_service.dart';
import 'package:be_universe/src/widgets/app_bar.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:be_universe/src/widgets/list_view/custom_list_view.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reusables/reusables.dart';

class SubscriptionOffersPage extends ControlledWidget<SubConfig> {
  SubscriptionOffersPage({
    Key? key,
  }) : super(key: key, controller: SubConfig.instance);

  @override
  State<SubscriptionOffersPage> createState() => _SubscriptionOffersPageState();
}

class _SubscriptionOffersPageState extends State<SubscriptionOffersPage>
    with ControlledStateMixin {
  late CustomListViewController<List<ProductDetails>> _listController;
  SubscriptionViewController? _viewController;

  var _absorb = false;

  @override
  void initState() {
    super.initState();
    _listController = CustomListViewController<List<ProductDetails>>(
      dataFunction: PurchaseService.instance.loadProducts,
      onDataFetched: () => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !widget.controller.isPending,
      child: AbsorbPointer(
        absorbing: _absorb || widget.controller.isPending,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBarWidget(),
          body: Stack(
            children: [
              BackgroundImageWidget(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top +
                        56 +
                        MediaQuery.of(context).viewPadding.top,
                    left: 30,
                    right: 30,
                  ),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          'Subscribe Today!',
                          style: GoogleFonts.oswald(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 21),
                      ),
                      SliverToBoxAdapter(
                        child: Text(
                          'You can cancel your subscription at any time',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(vertical: 46),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white30,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                height: 10,
                                width: 10,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF6272E4),
                                      Color(0xFFF09793),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: const EdgeInsets.symmetric(
                      //     vertical: 26,
                      //     horizontal: 24,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(20),
                      //     border: Border.all(
                      //       color: const Color(0xFF444A88),
                      //       width: 0.5,
                      //     ),
                      //   ),
                      //   child: Row(children: [
                      //     Text(
                      //       '1-Day Trial',
                      //       style: GoogleFonts.poppins(
                      //         fontSize: 16,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     const Spacer(),
                      //     Text(
                      //       'Free',
                      //       style: GoogleFonts.poppins(
                      //         fontSize: 15,
                      //         color: Colors.white54,
                      //       ),
                      //     ),
                      //   ]),
                      // ),
                      CustomListView<List<ProductDetails>>.sliver(
                        listViewController: _listController,
                        builder: (_, data) {
                          if (data.isEmpty) {
                            return const SliverToBoxAdapter(child: SizedBox());
                          }
                          _viewController ??= SubscriptionViewController(
                            products: data,
                          );
                          return SubscriptionView(
                            viewController: _viewController!,
                          );
                        },
                      ),
                      if (_listController.data?.isNotEmpty ?? false)
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(30, 50, 30, 50),
                          sliver: SliverToBoxAdapter(
                            child: AppButtonWidget(
                              onPressed: _purchase,
                              before: () => setState(() => _absorb = true),
                              after: () => setState(() => _absorb = false),
                              isIcon: false,
                              title: 'continue',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              ..._buildLoading(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _purchase() async {
    if (_viewController == null) {
      $showSnackBar(context, 'Something went wrong');
      return;
    }
    if (_viewController!.selected == null) {
      $showSnackBar(context, 'Please select a package');
      return;
    }
    try {
      await PurchaseService.instance.buyProduct(
        _viewController!.selected!,
        AppData().readLastUser().userid,
      );
    } catch (_) {
      rethrow;
    }
  }

  List<Widget> _buildLoading() {
    if (!widget.controller.isPending) {
      return [];
    }
    return [
      const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    ];
  }
}
