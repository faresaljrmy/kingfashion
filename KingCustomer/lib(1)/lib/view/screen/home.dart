import 'package:cached_network_image/cached_network_image.dart';
import 'package:kingfashion/controller/home_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/linkapi.dart';
import 'package:kingfashion/view/widget/customappbar.dart';
import 'package:kingfashion/view/widget/home/customcardhome.dart';
import 'package:kingfashion/view/widget/home/customtitlehome.dart';
import 'package:kingfashion/view/widget/home/listcategorieshome.dart';
import 'package:kingfashion/view/widget/home/listitemshome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeControllerImp());
    return GetBuilder<HomeControllerImp>(
        builder: (controller) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ListView(
              children: [
                CustomAppBar(
                  mycontroller: controller.search!,
                  titleappbar: "Find Product",
                  // onPressedIcon: () {},
                  onPressedSearch: () {
                    controller.onSearchItems();
                  },
                  onChanged: (val) {
                    controller.checkSearch(val);
                  },
                  onPressedIconFavorite: () {
                    Get.toNamed(AppRoute.myfavroite);
                  },
                ),
                HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: !controller.isSearch
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  // controller.goToAdminPage();
                                },
                                child: const CustomCardHome(
                                    title: "A summer surprise",
                                    body: "Cashback 20%"),
                              ),
                              const CustomTitleHome(title: "Categories"),
                              const ListCategoriesHome(),
                              const CustomTitleHome(title: "Product for you"),
                              const ListItemsHome(),
                            ],
                          )
                        : ListItemsSearch(listdatamodel: controller.listdata))

                // const CustomTitleHome(title: "Offer"),
                // const ListItemsHome()
              ],
            )));
  }
}

class ListItemsSearch extends GetView<HomeControllerImp> {
  final List<ItemsModel> listdatamodel;
  const ListItemsSearch({Key? key, required this.listdatamodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listdatamodel.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              controller.goToPageProductDetails(listdatamodel[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                  child: Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                        child: CachedNetworkImage(
                            imageUrl:
                                "${AppLink.imagestItems}/${listdatamodel[index].itemsImage}")),
                    Expanded(
                        flex: 2,
                        child: ListTile(
                          title: Text(listdatamodel[index].name!),
                          subtitle: Text(listdatamodel[index].categoriesName!),
                        )),
                  ],
                ),
              )),
            ),
          );
        });
  }
}
