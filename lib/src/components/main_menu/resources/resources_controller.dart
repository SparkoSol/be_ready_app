import 'package:be_universe_core/be_universe_core.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ResourceController extends ChangeNotifier {
  ResourceController({required this.type}) {
    controller = ScrollController()..addListener(loadMore);
    firstLoad();
  }

  final String type;

  void disposeListener() {
    controller.removeListener(loadMore);
  }

  var error = '';
  List<PaginatedResource>? paginatedResource;
  var dataList = <PaginatedResource>[];
  int pageNumber = 0;
  int limitSize = 20;
  bool isLoadingMore = false;
  bool isLoading = false;
  late ScrollController controller;
  bool hasNextPage = true;

  void firstLoad() async {
    try {
      isLoading = true;
      notifyListeners();
      paginatedResource = await ResourcesApi().getPaginatedResource(
          type, pageNumber.toString(), limitSize.toString());
      pageNumber = pageNumber += 1;
      for (var item in paginatedResource!) {
        dataList.add(item);
      }
      print('data List length ${dataList.length}');
    } catch (e) {
      print(e);
      if (e is DioError) {
        error = e.message;
      }
      error = e.toString();
    }
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
        final List<PaginatedResource> data = await ResourcesApi()
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

      if (e is DioError) {
        error = e.message;
      }
      error = e.toString();
    }
    isLoadingMore = false;
    notifyListeners();
  }
}
