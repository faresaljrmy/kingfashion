class AppLink {
//mamon14  172.17.115.113 phone 192.168.43.38
  // static const String server = "http://192.168.43.38/ecommerce";
  // static const String imagestatic = "http://192.168.43.38/ecommerce/upload";
//emlut=> 10.0.2.2  , 192.168.43.38 الشبكه حق جوالي
//=======================================================
  static const String server = "http://10.0.2.2/king";
  static const String imagestatic = "$server/upload";
//========================== Image ============================
  static const String imagestCategories = "$imagestatic/categories";
  static const String imagestItems = "$imagestatic/items";

  static const String notifications = "$server/notifications.php";

// ================================= Auth ========================== //
  static const String signUp = "$server/admin/auth/signup.php";
  static const String login = "$server/admin/auth/login.php";
  static const String verifycodessignup =
      "$server/admin/auth/verifycodesignup.php";
  static const String resend = "$server/admin/auth/resendverifycod.php";
// ================================= ForgetPassword ========================== //

  static const String checkEmail =
      "$server/admin/forgetpassword/checkemail.php";
  static const String resetPassword =
      "$server/admin/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword =
      "$server/admin/forgetpassword/verifycode.php";

  // Address

  static const String addressView = "$server/address/view.php";
  static const String addressAdd = "$server/address/add.php";
  static const String addressEdit = "$server/address/edit.php";
  static const String addressDelete = "$server/address/delete.php";

  //orders
  static const String orderspending = "$server/admin/orders/view_pending.php";
  static const String ordersapproved = "$server/admin/orders/approve.php";
  static const String ordersdone = "$server/admin/orders/done.php";
  static const String ordersaccepted = "$server/admin/orders/view_accepted.php";
  static const String ordersarchive = "$server/admin/orders/view_archive.php";
  static const String ordersdetalis = "$server/admin/orders/detalis.php";

  //Categories

  static const String categoriesview = "$server/admin/categories/view.php";
  static const String categoriesadd = "$server/admin/categories/add.php";
  static const String categoriesedit = "$server/admin/categories/edit.php";
  static const String categoriesdelete = "$server/admin/categories/delete.php";

  //items\
  static const String itemsview = "$server/admin/items/view.php";
  static const String itemsviewwithcolorsize =
      "$server/admin/items/viewwithcolorsize.php";
  static const String itemsadd = "$server/admin/items/add.php";
  static const String itemsedit = "$server/admin/items/edit.php";
  static const String itemsdelete = "$server/admin/items/delete.php";

  ////// itemcolorsize
  static const String itemcolorsizeadd = "$server/admin/itemcolorsizes/add.php";
  static const String itemcolorsizedelete =
      "$server/admin/itemcolorsizes/delete.php";
  static const String itemallsizecolordelete =
      "$server/admin/itemcolorsizes/deletecolor.php";
  static const String itemcolorsizeedit =
      "$server/admin/itemcolorsizes/edit.php";
  static const String itemcolorsizeview =
      "$server/admin/itemcolorsizes/view.php";

  // deliverys  signup
  static const String deliveryview = "$server/admin/deliverys/view.php";
  static const String deliveryadd = "$server/admin/deliverys/signup.php";
  static const String deliveryblock = "$server/admin/deliverys/block.php";
  static const String deliverdelete = "$server/admin/deliverys/delete.php";

// users
  static const String usersview = "$server/admin/users/view.php";

  // Colors Admin
  static const String colorAddPage = "$server/admin/colors/add.php";
  static const String colorDeletePage = "$server/admin/colors/delete.php";
  static const String colorEditPage = "$server/admin/colors/edit.php";
  static const String colorViewPage = "$server/admin/colors/view.php";

  // Sizes Admin
  static const String sizeAddPage = "$server/admin/sizes/add.php";
  static const String sizeDeletePage = "$server/admin/sizes/delete.php";
  static const String sizeEditPage = "$server/admin/sizes/edit.php";
  static const String sizeViewPage = "$server/admin/sizes/view.php";
}
