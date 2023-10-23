import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kingfashion/admin/routespageadmin.dart';
import 'package:kingfashion/bindings/intialbindings.dart';
import 'package:kingfashion/core/localization/changelocal.dart';
import 'package:kingfashion/core/localization/translation.dart';
import 'package:kingfashion/core/services/services.dart';
import 'package:kingfashion/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<GetPage<dynamic>> getRoutes() {
      List<GetPage<dynamic>> myroutes = routes!;
      myroutes.addAll(routesPageAdmin!);
      // myroutes.addAll(routesPageAdminEcommerce);
      return myroutes;
    }

    LocaleController controller = Get.put(LocaleController());
    return GetMaterialApp(
      translations: MyTranslation(),
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Course',
      locale: controller.language,
      theme: controller.appTheme,
      initialBinding: InitialBindings(),
      //  routes: routes,
      getPages: getRoutes(),
    );
  }
}
