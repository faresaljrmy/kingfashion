import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kingfashion/admin/view/screen/admin/item/additem.dart';
import 'package:kingfashion/admin/view/screen/admin/item/edititem.dart';
import 'package:kingfashion/admin/view/screen/admin/item/viewallitems.dart';
import 'package:kingfashion/admin/view/screen/admin/size/addsize.dart';
import 'package:kingfashion/admin/view/screen/admin/size/editsize.dart';
import 'package:kingfashion/admin/view/screen/admin/size/viewallsizes.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/admin/view/screen/admin/categoriesadmin/addcategorie.dart';
import 'package:kingfashion/admin/view/screen/admin/categoriesadmin/editcategorie.dart';
import 'package:kingfashion/admin/view/screen/admin/categoriesadmin/viewallcategories.dart';
import 'package:kingfashion/admin/view/screen/admin/color/addcolor.dart';
import 'package:kingfashion/admin/view/screen/admin/color/editcolor.dart';
import 'package:kingfashion/admin/view/screen/admin/color/viewallcolors.dart';
import 'package:kingfashion/admin/view/screen/admin/homeadmin.dart';

List<GetPage<dynamic>>? routesPageAdmin = [
  GetPage(name: AppRoute.adminhomepage, page: () => const HomeAdmin()),
  ///////// Categories
  GetPage(
      name: AppRoute.categoriespage,
      page: () => const ViewAllCategoriesAdmin()),
  GetPage(name: AppRoute.categoriesAddpage, page: () => const AddCategorie()),
  GetPage(name: AppRoute.categoriesEditpage, page: () => const EditCategorie()),
  /////// Colors
  GetPage(name: AppRoute.colorspage, page: () => const ViewAllColorsAdmin()),
  GetPage(name: AppRoute.colorsAddpage, page: () => const AddColor()),
  GetPage(name: AppRoute.colorsEditpage, page: () => const EditColor()),
  ///////// Sizes
  GetPage(name: AppRoute.sizespage, page: () => const ViewAllSizesAdmin()),
  GetPage(name: AppRoute.sizesAddpage, page: () => const AddSize()),
  GetPage(name: AppRoute.sizesEditpage, page: () => const EditSize()),

  ///////// Items
  GetPage(name: AppRoute.itemspage, page: () => const ViewAllItemsAdmin()),
  GetPage(name: AppRoute.itemsAddpage, page: () => const AddItems()),
  GetPage(name: AppRoute.itemsEditpage, page: () => const EditItems()),

// GetPage(name: AppRoute.categoriesEditpage, page: () => const HomeAdmin()),
];
