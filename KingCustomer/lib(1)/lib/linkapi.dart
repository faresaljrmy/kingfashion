class AppLink {
  static const String server = "http://10.0.2.2/king";

  /// Emulator
  // static const String server = "http://192.168.43.161/king"; //// Ethernet
  // static const String server = "http://192.168.43.161/king"; //// hotspot

  static const String imageststatic = "$server/upload";
//========================== Image ============================
  static const String imagestCategories = "$imageststatic/categories";
  static const String imagestItems = "$imageststatic/items";
// ==============================================items/===============
//
  static const String test = "$server/test.php";

  static const String notification = "$server/notification.php";

// ================================= Auth ========================== //

  static const String signUp = "$server/auth/signup.php";
  static const String login = "$server/auth/login.php";
  static const String verifycodessignup = "$server/auth/verfiycode.php";
  static const String resend = "$server/auth/resend.php";

// ================================= ForgetPassword ========================== //

  static const String checkEmail = "$server/forgetpassword/checkemail.php";
  static const String resetPassword =
      "$server/forgetpassword/resetpassword.php";
  static const String verifycodeforgetpassword =
      "$server/forgetpassword/verifycode.php";

// Home

  static const String homepage = "$server/home.php";
// items
  static const String items = "$server/items/items.php";
  static const String searchitems = "$server/items/search.php";
  static const String imagesitems = "$server/items/itemimages.php";

// Favorite

  static const String favoriteAdd = "$server/favorite/add.php";
  static const String favoriteRemove = "$server/favorite/remove.php";
  static const String deletemyfavorite =
      "$server/favorite/deletemyfavorite.php";
  static const String favoriteView = "$server/favorite/view.php";
  // static const String deletefromfavroite =
  //     "$server/favorite/deletefromfavroite.php";

  // Cart
  static const String cartview = "$server/cart/view.php";
  static const String cartadd = "$server/cart/add.php";
  static const String cartdelete = "$server/cart/deletesize.php";
  static const String cartgetcountitems = "$server/cart/getcountitems.php";

  // Address

  static const String addressView = "$server/address/view.php";
  static const String addressAdd = "$server/address/add.php";
  static const String addressEdit = "$server/address/edit.php";
  static const String addressDelete = "$server/address/delete.php";

  // Productdetails

  static const String detailsgetcolorsitem =
      "$server/itemdetails/getcolorsitem.php";

  // Coupon

  static const String checkcoupon = "$server/coupon/checkcoupon.php";

  // Checkout

  static const String checkout = "$server/orders/checkout.php";

  static const String pendingorders = "$server/orders/pending.php";
  static const String ordersarchive = "$server/orders/archive.php";
  static const String ordersdetails = "$server/orders/details.php";
  static const String ordersdelete = "$server/orders/delete.php";
  // Home Admin

  static const String homeadminpage = "$server/admin/home.php";
  // Categories Admin
  static const String categoriesAddPage = "$server/admin/categories/add.php";
  static const String categoriesDeletePage =
      "$server/admin/categories/delete.php";
  static const String categoriesEditPage = "$server/admin/categories/edit.php";
  static const String categoriesViewPage = "$server/admin/categories/view.php";

  // Colors Admin
  static const String colorAddPage = "$server/admin/colors/add.php";
  static const String colorDeletePage = "$server/admin/colors/delete.php";
  static const String colorEditPage = "$server/admin/colors/edit.php";
  static const String colorViewPage = "$server/admin/colors/view.php";

  // Items Admin
  static const String itemsAddPage = "$server/admin/items/add.php";
  static const String itemsDeletePage = "$server/admin/items/delete.php";
  static const String itemsEditPage = "$server/admin/items/edit.php";
  static const String itemsViewPage = "$server/admin/items/view.php";

  // Sizes Admin
  static const String sizeAddPage = "$server/admin/sizes/add.php";
  static const String sizeDeletePage = "$server/admin/sizes/delete.php";
  static const String sizeEditPage = "$server/admin/sizes/edit.php";
  static const String sizeViewPage = "$server/admin/sizes/view.php";
}
