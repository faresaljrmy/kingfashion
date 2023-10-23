import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/core/middleware/mymiddleware.dart';
import 'package:kingfashion/test_view.dart';
import 'package:kingfashion/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:kingfashion/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:kingfashion/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:kingfashion/view/screen/auth/forgetpassword/verifycode.dart';
import 'package:kingfashion/view/screen/auth/login.dart';
import 'package:kingfashion/view/screen/auth/signup.dart';
import 'package:kingfashion/view/screen/auth/success_signup.dart';
import 'package:kingfashion/view/screen/auth/verifycodesignup.dart';
import 'package:kingfashion/view/screen/cart/cart.dart';
import 'package:kingfashion/view/screen/cart/cart_productdetails.dart';
import 'package:kingfashion/view/screen/homescreen.dart';
import 'package:kingfashion/view/screen/items.dart';
import 'package:kingfashion/view/screen/language.dart';
import 'package:kingfashion/view/screen/myfavorite.dart';
import 'package:kingfashion/view/screen/onboarding.dart';
import 'package:kingfashion/view/screen/productdetails.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
      name: "/", page: () => const Language(), middlewares: [MyMiddleWare()]),
  GetPage(name: "/", page: () => const TestView()),
  GetPage(name: AppRoute.cart, page: () => const Cart()),
//  Auth
  GetPage(name: AppRoute.login, page: () => const Login()),
  GetPage(name: AppRoute.signUp, page: () => const SignUp()),
  GetPage(name: AppRoute.forgetPassword, page: () => const ForgetPassword()),
  GetPage(name: AppRoute.verfiyCode, page: () => const VerfiyCode()),
  GetPage(name: AppRoute.resetPassword, page: () => const ResetPassword()),
  GetPage(
      name: AppRoute.successResetpassword,
      page: () => const SuccessResetPassword()),
  GetPage(name: AppRoute.successSignUp, page: () => const SuccessSignUp()),
  GetPage(name: AppRoute.onBoarding, page: () => const OnBoarding()),
  GetPage(
      name: AppRoute.verfiyCodeSignUp, page: () => const VerfiyCodeSignUp()),
//   //
  GetPage(name: AppRoute.homepage, page: () => const HomeScreen()),
  GetPage(name: AppRoute.items, page: () => const Items()),
  GetPage(name: AppRoute.productdetails, page: () => const ProductDetails()),
  GetPage(
      name: AppRoute.productdetailsCart,
      page: () => const CartProductDetails()),
  GetPage(name: AppRoute.myfavroite, page: () => const MyFavorite()),
//   //
//   GetPage(name: AppRoute.addressview, page: () => const AddressView()),
//   GetPage(name: AppRoute.addressadd, page: () => const AddressAdd()),
//   GetPage(name: AppRoute.checkout, page: () => const Checkout()),
//   GetPage(name: AppRoute.orderspending, page: () => const OrdersPending()),
//   GetPage(name: AppRoute.ordersarchive, page: () => const OrdersArchiveView()),
//   GetPage(name: AppRoute.ordersdetails, page: () => const OrdersDetails()),
//   GetPage(
//       name: AppRoute.addressadddetails, page: () => const AddressAddDetails()),

//////
//////  Admin pages alqissy
  // GetPage(name: AppRoute.dashboard, page: () => const Dashboard()),
];
