import 'package:be_universe/src/services/purchase_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:reusables/reusables.dart';

class SubscriptionViewController extends ChangeNotifier {
  SubscriptionViewController({
    required this.products,
  }) {
    selected ??= products.first;
  }

  final List<ProductDetails> products;

  ProductDetails? selected;

  void changeSelection(ProductDetails value) {
    selected = value;
    notifyListeners();
  }
}

class SubscriptionView extends ControlledWidget<SubscriptionViewController> {
  const SubscriptionView({
    Key? key,
    required this.viewController,
  }) : super(key: key, controller: viewController);

  final SubscriptionViewController viewController;

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView>
    with ControlledStateMixin {
  List<ProductDetails> get _products => widget.controller.products;
  var _monthlyPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = _products[index];
          if (product.isMonthly) {
            _monthlyPrice = product.rawPrice;
          }
          final isSelected = widget.controller.selected == product;
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: index == 0 ? 24 : 0,
            ),
            child: GestureDetector(
              onTap: () => widget.controller.changeSelection(product),
              child: Stack(fit: StackFit.loose, children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  padding: const EdgeInsets.fromLTRB(31, 37, 24, 17),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                    color: isSelected ? null : Colors.transparent,
                    border: isSelected
                        ? null
                        : Border.all(
                            color: const Color(0xFF444A88),
                            width: 0.5,
                          ),
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [
                              Color(0xFFD2876F),
                              Color(0xFF523072),
                            ],
                          )
                        : null,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              product.appTitle(_monthlyPrice),
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            '${product.currencySymbol}${product.perDay}/day',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Start your 3 days free trial then',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text.rich(TextSpan(
                        text:
                            '${product.currencySymbol}${product.rawPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                        children: [
                          TextSpan(
                            text: ' per ${product.per}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                ),
                if (product.isYearly)
                  Positioned(
                    right: 0,
                    child: Container(
                      width: 120,
                      height: 25,
                      padding: const EdgeInsets.only(top: 5),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Text(
                        'Best Value',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: const Color(0Xff9A6170),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          );
        },
        childCount: _products.length,
      ),
    );
  }
}

extension _Format on ProductDetails {
  double get _monthlyPrice => isYearly ? rawPrice / 12 : rawPrice;

  bool get isYearly => id == PurchaseService.instance.yearlyId;

  bool get isMonthly => id == PurchaseService.instance.monthlyId;

  String get per {
    if (isMonthly) return 'Month';
    if (isYearly) return 'Year';
    return '';
  }

  String appTitle(double mPrice) {
    if (isMonthly) {
      return 'Monthly';
    } else if (isYearly) {
      final off = '(${(100 - (rawPrice / (mPrice * 12)) * 100).toInt()}% off)';
      return 'Annual $off';
    } else {
      return '';
    }
  }

  String get perDay => (_monthlyPrice / 30).toStringAsFixed(2);
}
