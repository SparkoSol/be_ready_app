import 'package:be_ready_app/src/base/modals/app_snackbar.dart';
import 'package:be_universe_core/be_universe_core.dart';
import 'package:flutter/material.dart';

class ResourceController extends ChangeNotifier {
  ResourceController({required this.type, required this.context}) {
    controller = ScrollController()..addListener(loadMore);
    firstLoad(context);
  }

  final BuildContext context;
  final String type;

  void disposeListener() {
    controller.removeListener(loadMore);
  }

  var error = '';
  List<ResourceResponse> paginatedResource = [];
  var dataList = <ResourceResponse>[];
  int pageNumber = 0;
  int limitSize = 20;
  bool isLoadingMore = false;
  bool isLoading = false;
  late ScrollController controller;
  bool hasNextPage = true;

  void firstLoad(BuildContext context) async {
    // try {
    isLoading = true;
    notifyListeners();
    paginatedResource = await ResourcesApi().getPaginatedResource(
        type, pageNumber.toString(), limitSize.toString());
    pageNumber = pageNumber += 1;
    for (var item in paginatedResource) {
      dataList.add(item);
    }
    print('data List length ${dataList.length}');
    // } catch (e) {
    //   print(e);
    //   $showSnackBar(context, e.toString());
    // }
    isLoading = false;
    notifyListeners();
  }

  void loadMore() async {
    try {
      if (hasNextPage == true &&
          isLoading == false &&
          isLoadingMore == false &&
          controller.position.extentAfter < 300) {
        isLoadingMore = true;
        notifyListeners();
        pageNumber = pageNumber += 1;
        final List<ResourceResponse> data = await ResourcesApi()
            .getPaginatedResource(
                type, pageNumber.toString(), limitSize.toString());

        if (data.isNotEmpty) {
          for (var item in data) {
            dataList.add(item);
          }
        } else if (data.length <= 5) {
          hasNextPage = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print(e);
      $showSnackBar(context, e.toString());

      // if (e is DioError) {
      //   error = e.message;
      // }
      // error = e.toString();
    }
    isLoadingMore = false;
    notifyListeners();
  }
}
