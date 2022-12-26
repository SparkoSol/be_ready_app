import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

class PurchaseService {
  PurchaseService._internal();

  static final _instance = PurchaseService._internal();

  factory PurchaseService() => _instance;

  final _monthly = 'monthly';
  final _yearly = 'yearly';
  var _products = <ProductDetails>[];

  List<ProductDetails> get products => _products;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final _purchase = InAppPurchase.instance;

  Future<void> init() async {
    try {
      _subscription = _purchase.purchaseStream.listen(
        (event) {},
        onDone: () {},
      );
    } catch (_) {}
  }

  Future<List<ProductDetails>> loadProducts() async {
    try {
      if (_products.isNotEmpty) return _products;
      final response = await _purchase.queryProductDetails(
        {_monthly, _yearly},
      );
      if (response.error != null) {
        throw response.error!.message;
      }
      if (response.productDetails.isEmpty) {
        throw 'In app purchase is not available';
      }
      _products = response.productDetails;
      return _products;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> buyProduct(ProductDetails product, String userId) async {
    try {
      _purchase.buyNonConsumable(
        purchaseParam: PurchaseParam(
          productDetails: product,
          applicationUserName: userId,
        ),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> dispose() async {
    if (_subscription != null) {
      await _subscription!.cancel();
    }
  }
}
