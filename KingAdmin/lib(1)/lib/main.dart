import 'package:adminkingfashion/bindings/initialbinding.dart';
import 'package:adminkingfashion/core/localization/changelocallangcontroller.dart';
import 'package:adminkingfashion/core/services/services.dart';
import 'package:adminkingfashion/routse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: controller.language,
      theme: controller.apptheme,
      initialBinding: InitialBinding(),
      getPages: routes,
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(
          // //default toast widget
          // toastBuilder: (String msg) => CustomToastWidget(msg: msg),
          // //default loading widget
          // loadingBuilder: (String msg) => CustomLoadingWidget(msg: msg),
          ),
    );
  }
}
