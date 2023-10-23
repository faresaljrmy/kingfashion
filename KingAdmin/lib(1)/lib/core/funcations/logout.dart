import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

MyServices myServices = Get.find();
// BuildContext? context;
showConfirmLogout(BuildContext context) {
  showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoActionSheet(
      message: Text("72".tr),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            String userid = myServices.sharedPreferences.getString("id")!;
            FirebaseMessaging.instance.unsubscribeFromTopic("user");
            FirebaseMessaging.instance.unsubscribeFromTopic("user$userid");
            myServices.sharedPreferences.clear();
            Get.offAllNamed(AppRoute.login);
          },
          child: Text(
            "73".tr,
            style: const TextStyle(color: AppColors.primaryColor),
          ),
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("74".tr),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ),
  );
}
