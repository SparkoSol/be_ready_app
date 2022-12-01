import 'dart:io';

import 'package:be_universe/src/widgets/list_view/custom_list_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reusables/reusables.dart';
import 'package:shimmer/shimmer.dart';

class CustomListView<T> extends ControlledWidget<CustomListViewController<T>> {
  const CustomListView.simpler({
    Key? key,
    required this.listViewController,
    required this.builder,
    this.errorWidget,
    this.noDataWidget,
    this.loadingWidget,
    this.baseColor,
    this.highLightColor,
    this.shimmerWidget,
  })  : _type = _CustomListType.simpler,
        super(key: key, controller: listViewController);

  const CustomListView.sliver({
    Key? key,
    required this.listViewController,
    required this.builder,
    this.errorWidget,
    this.noDataWidget,
    this.loadingWidget,
    this.baseColor,
    this.highLightColor,
    this.shimmerWidget,
  })  : _type = _CustomListType.sliver,
        super(key: key, controller: listViewController);

  final CustomListViewController<T> listViewController;
  final Widget? errorWidget;
  final Widget? noDataWidget;
  final Widget? loadingWidget;
  final Widget Function(BuildContext context, T data) builder;
  final Color? baseColor;
  final Color? highLightColor;
  final _CustomListType _type;
  final Widget? shimmerWidget;

  @override
  State<CustomListView<T>> createState() => _CustomListViewState<T>();
}

class _CustomListViewState<T> extends State<CustomListView<T>>
    with ControlledStateMixin {
  @override
  Widget build(BuildContext context) {
    late Widget shimmerWidget;
    switch (widget._type) {
      case _CustomListType.simpler:
        shimmerWidget = Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Shimmer.fromColors(
              baseColor: widget.baseColor ?? Colors.indigo.withOpacity(0.5),
              highlightColor: widget.highLightColor ?? Colors.white30,
              child: ListView.builder(
                itemBuilder: _cardBuilder,
                itemCount: 5,
              ),
            ),
          ),
        );
        break;
      case _CustomListType.sliver:
        shimmerWidget = SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              _cardBuilder,
              childCount: 5,
            ),
          ),
        );
        break;
    }
    final loadingWidget = widget.loadingWidget ?? shimmerWidget;
    final subLoadingWidget = Platform.isAndroid
        ? const CircularProgressIndicator()
        : const CupertinoActivityIndicator();
    final noDataWidget = widget.noDataWidget ??
        const Center(
          child: Text('Data not found!'),
        );
    final errorWidget = Center(
      child: widget.errorWidget ??
          Column(children: [
            const Icon(Icons.warning_amber_rounded, size: 70),
            Text(widget.controller.error?.description ?? ''),
          ]),
    );
    if (widget.controller.isLoading) {
      return loadingWidget;
    } else if (widget.controller.error != null) {
      switch (widget._type) {
        case _CustomListType.simpler:
          return errorWidget;
        case _CustomListType.sliver:
          return SliverToBoxAdapter(child: errorWidget);
      }
    } else if (widget.controller.data == null &&
        widget.controller.listData.isEmpty) {
      switch (widget._type) {
        case _CustomListType.simpler:
          return noDataWidget;
        case _CustomListType.sliver:
          return SliverToBoxAdapter(child: noDataWidget);
      }
    } else {
      if (widget.controller.isList) {
        switch (widget._type) {
          case _CustomListType.simpler:
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: widget.controller.scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: widget.controller.listData.length,
                    itemBuilder: (ctx, index) {
                      return widget.builder(
                          ctx, widget.controller.listData[index]);
                    },
                  ),
                ),
                if (widget.controller.isSubLoading) subLoadingWidget,
              ],
            );
          case _CustomListType.sliver:
            var count = widget.controller.listData.length;
            if (widget.controller.isSubLoading) count++;
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, index) {
                  if (index == widget.controller.listData.length) {
                    return subLoadingWidget;
                  }
                  return widget.builder(ctx, widget.controller.listData[index]);
                },
                childCount: count,
              ),
            );
        }
      } else {
        return widget.builder(context, widget.controller.data as T);
      }
    }
  }

  Widget _cardBuilder(BuildContext context, int index) {
    if (widget.shimmerWidget != null) {
      return widget.shimmerWidget!;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: const SizedBox(
        height: 150,
        width: double.infinity,
      ),
    );
  }
}

enum _CustomListType { simpler, sliver }
