import 'package:adminkingfashion/core/class/statusrequest.dart';
import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataView(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250),
          )
        : statusRequest == StatusRequest.offlinefailure
            ? Center(
                child: Lottie.asset(AppImageAsset.offline,
                    width: 250, height: 250))
            : statusRequest == StatusRequest.serverfailure
                ? Center(
                    child: Lottie.asset(AppImageAsset.server,
                        width: 250, height: 250))
                : statusRequest == StatusRequest.failure
                    ? Center(
                        child: Lottie.asset(AppImageAsset.noData,
                            width: 250, height: 250))
                    : widget;
  }
}

class HandlingDataViewRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataViewRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Stack(
            children: [
              widget,
              // Container(
              //   color: Colors.black.withOpacity(0.5),
              //   child: const Center(
              //       // child: CircularProgressIndicator(),
              //       ),
              // ),
            ],
          )
        : widget;
    // statusRequest == StatusRequest.loading
    //     ? Center(
    //         child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250),
    //       )
    //     : statusRequest == StatusRequest.offlinefailure
    //         ? Center(
    //             child: Lottie.asset(AppImageAsset.offline,
    //                 width: 250, height: 250))
    //         : statusRequest == StatusRequest.serverfailure
    //             ? Center(
    //                 child: Lottie.asset(AppImageAsset.server,
    //                     width: 250, height: 250))
    //             : widget;
  }
}

class HandlingDataWidgetRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;
  const HandlingDataWidgetRequest(
      {super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : widget;
    // statusRequest == StatusRequest.loading
    //     ? Center(
    //         child: Lottie.asset(AppImageAsset.loading, width: 250, height: 250),
    //       )
    //     : statusRequest == StatusRequest.offlinefailure
    //         ? Center(
    //             child: Lottie.asset(AppImageAsset.offline,
    //                 width: 250, height: 250))
    //         : statusRequest == StatusRequest.serverfailure
    //             ? Center(
    //                 child: Lottie.asset(AppImageAsset.server,
    //                     width: 250, height: 250))
    //             : widget;
  }
}
