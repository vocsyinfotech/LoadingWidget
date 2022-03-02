import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:pull_to_refresh/src/smart_refresher.dart';

import 'box.dart';

class VideoList extends StatelessWidget {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    print('============PAGE===============');
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    print('============PAGE===============');
    _refreshController.loadComplete();
  }

  bool isLastPage = false;
  List? list;
  int page = 1;
  Future<void> loadFirstData() async {
    await Future.delayed(Duration(seconds: 1), () {});
  }

  Future<void> _handleRefresh() async {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
  }

  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
      GlobalKey<LiquidPullToRefreshState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.pink,
            height: MediaQuery.of(context).size.height - 142,
            child: LiquidPullToRefresh(
              key: _refreshIndicatorKey,
              onRefresh: _handleRefresh,
              child: InViewNotifierList(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                scrollDirection: Axis.vertical,
                initialInViewIds: ['0'],
                isInViewPortCondition: (double deltaTop, double deltaBottom,
                    double viewPortDimension) {
                  return deltaTop < (0.5 * viewPortDimension) &&
                      deltaBottom > (0.5 * viewPortDimension);
                },
                itemCount: 7,
                builder: (BuildContext context, int index) {
                  return index == 0
                      ? Container(
                          height: 100,
                          color: Colors.black,
                        )
                      : Container(
                          width: double.infinity,
                          height: 300.0,
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 50.0),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Container(
                                width: double.infinity,
                                height: 300.0,
                                color: Colors.blueGrey,
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: 50.0),
                                child: Box(id: '$index'),
                              );
                              // return InViewNotifierWidget(
                              //   id: '$index',
                              //   builder: (BuildContext context, bool isInView,
                              //       Widget? child) {
                              //     return VideoWidget(
                              //         play: isInView,
                              //         url:
                              //             'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
                              //   },
                              // );
                            },
                          ),
                        );
                },
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 1.0,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
    );
    // return Stack(
    //   fit: StackFit.expand,
    //   children: <Widget>[
    //     InViewNotifierList(
    //       scrollDirection: Axis.vertical,
    //       initialInViewIds: ['0'],
    //       isInViewPortCondition:
    //           (double deltaTop, double deltaBottom, double viewPortDimension) {
    //         return deltaTop < (0.5 * viewPortDimension) &&
    //             deltaBottom > (0.5 * viewPortDimension);
    //       },
    //       itemCount: 10,
    //       builder: (BuildContext context, int index) {
    //         return Container(
    //           width: double.infinity,
    //           height: 300.0,
    //           alignment: Alignment.center,
    //           margin: EdgeInsets.symmetric(vertical: 50.0),
    //           child: LayoutBuilder(
    //             builder: (BuildContext context, BoxConstraints constraints) {
    //               return InViewNotifierWidget(
    //                 id: '$index',
    //                 builder:
    //                     (BuildContext context, bool isInView, Widget? child) {
    //                   return VideoWidget(
    //                       play: isInView,
    //                       url:
    //                           'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    //                 },
    //               );
    //             },
    //           ),
    //         );
    //       },
    //     ),
    //     Align(
    //       alignment: Alignment.center,
    //       child: Container(
    //         height: 1.0,
    //         color: Colors.redAccent,
    //       ),
    //     )
    //   ],
    // );
  }
}
