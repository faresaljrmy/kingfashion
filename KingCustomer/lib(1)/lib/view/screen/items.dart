import 'package:kingfashion/controller/favorite_controller.dart';
import 'package:kingfashion/controller/items_controller.dart';
import 'package:kingfashion/core/class/handlingdataview.dart';
import 'package:kingfashion/core/constant/routes.dart';
import 'package:kingfashion/data/model/itemsmodel.dart';
import 'package:kingfashion/view/screen/home.dart';
import 'package:kingfashion/view/widget/customappbar.dart';
import 'package:kingfashion/view/widget/items/customlistitems.dart';
import 'package:kingfashion/view/widget/items/listcategoirseitems.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Items extends StatelessWidget {
  const Items({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemsControllerImp controller = Get.put(ItemsControllerImp());
    FavoriteController controllerFav = Get.put(FavoriteController());

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(children: [
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
          const SizedBox(height: 20),
          const ListCategoriesItems(),
          GetBuilder<ItemsControllerImp>(
              builder: (controller) => HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: !controller.isSearch
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.listItems.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.7),
                          itemBuilder: (BuildContext context, index) {
                            ItemsModel itemsModel = controller.listItems[index];
                            return CustomListItems(
                              itemsModel: itemsModel,
                              onPressedFav: () async {
                                if (itemsModel.favorite == "1") {
                                  await controller.removeFavorite(
                                      itemsModel.id!, index);
                                } else {
                                  await controller.addFavorite(
                                      itemsModel.id!, index);
                                }
                              },
                            );
                          })
                      : ListItemsSearch(listdatamodel: controller.listdata)))
        ]),
      ),
    );
  }
}





















// favoriteController.isFavorite[controller.data[index]
                            // ['items_id']] = controller.data[index]['favorite'];
