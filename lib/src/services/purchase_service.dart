import 'dart:async';
import 'dart:io';
import 'package:be_universe/src/components/subscription/offers/sub_config.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PurchaseService {
  PurchaseService._();

  static final _instance = PurchaseService._();

  static PurchaseService get instance => _instance;

  final _monthly = 'monthly';
  final _yearly = 'yearly';

  String get monthlyId => _monthly;

  String get yearlyId => _yearly;

  var _products = <ProductDetails>[];

  List<ProductDetails> get products => _products;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final _purchase = InAppPurchase.instance;

  Future<void> init() async {
    try {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      for (final tr in transactions) {
        await paymentWrapper.finishTransaction(tr);
      }
      print('RRRRRRRRRRRRRRR: Listener Started');
      _subscription = _purchase.purchaseStream.listen(
        (event) async {
          print('RRRRRRRRRRRRRRR: Event');
          for (final detail in event) {
            switch (detail.status) {
              case PurchaseStatus.pending:
                print('RRRRRRRRRRRRRRR: Pending');
                SubConfig.instance.isPending = true;
                break;
              case PurchaseStatus.error:
                print('RRRRRRRRRRRRRRR: There was an error while purchasing');
                SubConfig.instance.isPending = false;
                break;
              case PurchaseStatus.purchased:
              case PurchaseStatus.restored:
                print('RRRRRRRRRRRRRRR: Purchased');
                if (Platform.isAndroid) {
                  final InAppPurchaseAndroidPlatformAddition androidAddition =
                      _purchase.getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();
                  await androidAddition.consumePurchase(detail);
                }
                if (detail.pendingCompletePurchase) {
                  print(detail.verificationData.serverVerificationData);
                  print(detail.verificationData.localVerificationData);
                  print(detail.verificationData.source);
                  await _purchase.completePurchase(detail);
                }
                SubConfig.instance.isPending = false;
                break;
              case PurchaseStatus.canceled:
                print('RRRRRRRRRRRRRRR: Canceled');
                SubConfig.instance.isPending = false;
                break;
            }
          }
        },
        onDone: () {
          print('RRRRRRRRRRRRRRR: Done');
        },
        onError: (error) {
          print('RRRRRRRRRRRRRRR: Error');
          print(error);
        },
      );
      await loadProducts();
    } catch (_) {
      print('RRRRRRRRRRRRRRR: In Error');
    }
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
      await _purchase.buyNonConsumable(
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
