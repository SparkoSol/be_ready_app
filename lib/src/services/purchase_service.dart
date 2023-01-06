import 'dart:async';
import 'dart:io';
import 'package:be_universe/src/components/subscription/offers/sub_config.dart';
import 'package:be_universe/src/widgets/premium/premium_controller.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';

class PurchaseService {
  PurchaseService._();

  static final _instance = PurchaseService._();

  static PurchaseService get instance => _instance;

  final _monthly = 'monthly';
  final _yearly = 'yearly';

  // final _iosPassword = '217d5130db2d4392932140d5b07231ee';

  String get monthlyId => _monthly;

  String get yearlyId => _yearly;

  var _products = <ProductDetails>[];

  List<ProductDetails> get products => _products;

  StreamSubscription<List<PurchaseDetails>>? _subscription;

  final _purchase = InAppPurchase.instance;

  var _isRestored = false;

  Future<void> init() async {
    try {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      for (final tr in transactions) {
        await paymentWrapper.finishTransaction(tr);
      }
      _subscription = _purchase.purchaseStream.listen(
        (event) async {
          for (final detail in event) {
            print('Event Status:: ${detail.status}');
            switch (detail.status) {
              case PurchaseStatus.pending:
                SubConfig.instance.isPending = true;
                break;
              case PurchaseStatus.error:
                SubConfig.instance.isFailed = true;
                SubConfig.instance.isPending = false;
                break;
              case PurchaseStatus.purchased:
              case PurchaseStatus.restored:
                if (_isRestored) return;
                _isRestored = detail.status == PurchaseStatus.restored;
                if (Platform.isAndroid) {
                  final InAppPurchaseAndroidPlatformAddition androidAddition =
                      _purchase.getPlatformAddition<
                          InAppPurchaseAndroidPlatformAddition>();
                  await androidAddition.consumePurchase(detail);
                }
                await _verifyPurchase(
                  detail,
                  detail.status == PurchaseStatus.restored,
                );
                if (detail.pendingCompletePurchase) {
                  await _purchase.completePurchase(detail);
                }
                SubConfig.instance.isPending = false;
                break;
              case PurchaseStatus.canceled:
                SubConfig.instance.isFailed = true;
                SubConfig.instance.isPending = false;
                break;
            }
          }
          PremiumController.instance.fetchUser();
        },
        onDone: () {},
        onError: (error) {},
      );
      await loadProducts();
    } catch (_) {}
  }

  // Future<void> getPurchases() async {
  //   try {
  //     await FlutterInappPurchase.instance.initialize();
  //     final history = await FlutterInappPurchase.instance.getPurchaseHistory();
  //     print('RRRRRRRRRRRRRRRRRRRRRRRRRRR');
  //     print(history?.length ?? 'Null');
  //     if (history == null) return;
  //     for (var element in history) {
  //       print('====');
  //       print(element.originalTransactionIdentifierIOS);
  //       print('----');
  //     }
  //   } catch (e) {
  //     print('EEEEEEEEE');
  //     print(e);
  //   }
  // }

  final _api = ProfileApi();

  Future<dynamic> _verifyPurchase(
    PurchaseDetails detail,
    bool isRestored,
  ) async {
    try {
      final lastUser = AppData().readLastUser();
      await _api.updateReceipt(
        lastUser.userid,
        UpdateReceiptRequest(
          receiptToken: detail.verificationData.serverVerificationData,
          transfer: isRestored,
        ),
      );
      // await Dio().post(
      //   'https://sandbox.itunes.apple.com/verifyReceipt',
      //   data: {
      //     'receipt-data': detail.verificationData.serverVerificationData,
      //     'password': _iosPassword,
      //     'exclude-old-transactions': true,
      //   },
      // );
    } catch (_) {
      rethrow;
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
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      for (final tr in transactions) {
        await paymentWrapper.finishTransaction(tr);
      }
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

  Future<void> restorePurchase(String userId) async {
    try {
      final paymentWrapper = SKPaymentQueueWrapper();
      final transactions = await paymentWrapper.transactions();
      for (final tr in transactions) {
        await paymentWrapper.finishTransaction(tr);
      }
      await _purchase.restorePurchases(
        applicationUserName: userId,
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
