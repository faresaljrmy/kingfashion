// ignore: depend_on_referenced_packages
import 'package:adminkingfashion/core/constant/routes.dart';
import 'package:adminkingfashion/core/middelwhere/mymiddelwhere.dart';
import 'package:adminkingfashion/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:adminkingfashion/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:adminkingfashion/view/screen/auth/forgetpassword/succss_resetpassword.dart';
import 'package:adminkingfashion/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:adminkingfashion/view/screen/auth/login.dart';
import 'package:adminkingfashion/view/screen/color/addcolor.dart';
import 'package:adminkingfashion/view/screen/color/editcolor.dart';
import 'package:adminkingfashion/view/screen/color/viewallcolors.dart';
import 'package:adminkingfashion/view/screen/deliverys/add.dart';
import 'package:adminkingfashion/view/screen/auth/succss_signup.dart';
import 'package:adminkingfashion/view/screen/auth/verifycodesignup.dart';
import 'package:adminkingfashion/view/screen/categories/add.dart';
import 'package:adminkingfashion/view/screen/categories/edit.dart';
import 'package:adminkingfashion/view/screen/categories/view.dart';
import 'package:adminkingfashion/view/screen/deliverys/view.dart';
import 'package:adminkingfashion/view/screen/home/dashboard_screen.dart';
import 'package:adminkingfashion/view/screen/items/add.dart';
import 'package:adminkingfashion/view/screen/items/itemcolorsize/addcoloritem.dart';
import 'package:adminkingfashion/view/screen/items/edit.dart';
import 'package:adminkingfashion/view/screen/items/itemcolorsize/editcoloritem.dart';
import 'package:adminkingfashion/view/screen/items/view.dart';
import 'package:adminkingfashion/view/screen/orders/archive.dart';
import 'package:adminkingfashion/view/screen/orders/detalis.dart';
import 'package:adminkingfashion/view/screen/orders/order_screen.dart';
import 'package:adminkingfashion/view/screen/orders/pending.dart';
import 'package:adminkingfashion/view/screen/size/addsize.dart';
import 'package:adminkingfashion/view/screen/size/editsize.dart';
import 'package:adminkingfashion/view/screen/size/viewallsizes.dart';
import 'package:adminkingfashion/view/screen/users/view.dart';
import 'package:get/get.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: "/", page: () => const Login(), middlewares: [MyMiddleWare()]),

// test
// GetPage(name:"/" ,page:()=>const Cart()),
  //Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(
      name: AppRoute.verfiyCodeSignUp, page: () => const VerifyCodeSignUp()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccssSignUp()),

  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerifyCode()),
  GetPage(
      name: AppRoute.successResetpassword,
      page: () => const SuccssResetPassword()),

  GetPage(name: AppRoute.dashboard, page: () => const Dashboard()),
  GetPage(name: AppRoute.categoriesview, page: () => const CategoresView()),
  GetPage(name: AppRoute.categoriesadd, page: () => const CategoriesAdd()),
  GetPage(name: AppRoute.categoriesedit, page: () => const CategoriesEdit()),
// items
  GetPage(name: AppRoute.itemsedit, page: () => const ItemsEdit()),
  GetPage(name: AppRoute.itemsview, page: () => const ItemsView()),
  GetPage(name: AppRoute.itemsadd, page: () => const ItemsAdd()),
  GetPage(name: AppRoute.itemsaddcolor, page: () => const ItemsAddColor()),
  GetPage(name: AppRoute.itemseditcolor, page: () => const ItemsEditColor()),

  //Address
//  GetPage(name:AppRoute.addressview ,page:()=>const AddressView()),
//  GetPage(name:AppRoute.checkout ,page:()=>const Checkout()),
  //Orders
  GetPage(name: AppRoute.orderscreen, page: () => const OrderScreen()),
  GetPage(name: AppRoute.pendingorders, page: () => const PendigOrdersPage()),
  GetPage(name: AppRoute.archiveorders, page: () => const ArchiveOrdersPage()),
  GetPage(name: AppRoute.detalisorders, page: () => const OrderDetalisPage()),
// deliverys
  GetPage(name: AppRoute.deliverysview, page: () => const DeliverysView()),
  GetPage(name: AppRoute.deliverysadd, page: () => const DeliveryAdd()),

  // users UsersView
  GetPage(name: AppRoute.usersview, page: () => const UsersView()),

  /////// Colors
  GetPage(name: AppRoute.colorspage, page: () => const ViewAllColorsAdmin()),
  GetPage(name: AppRoute.colorsAddpage, page: () => const AddColor()),
  GetPage(name: AppRoute.colorsEditpage, page: () => const EditColor()),
  ///////// Sizes
  GetPage(name: AppRoute.sizespage, page: () => const ViewAllSizesAdmin()),
  GetPage(name: AppRoute.sizesAddpage, page: () => const AddSize()),
  GetPage(name: AppRoute.sizesEditpage, page: () => const EditSize()),
];
