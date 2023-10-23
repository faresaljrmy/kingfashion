import 'package:adminkingfashion/controller/home/homepage_controller.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageControllerImp controller = Get.put(HomePageControllerImp());
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: GetBuilder<HomePageControllerImp>(
            builder: (controller) => ListView(
                  children: const [],
                )));
  }
}

// class ListItemsSearch extends GetView<HomePageControllerImp> {
//   final List<ItemsModel> listdatamodel;
//   const ListItemsSearch({Key? key, required this.listdatamodel})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: listdatamodel.length,
//         shrinkWrap: true,
//         physics:const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               controller.goToItemsDetalis(listdatamodel[index]);
//             },
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 20),
//               child: Card(
//                   child: Container(
//                 padding:const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                         child: CachedNetworkImage(
//                             imageUrl:
//                                 "${AppLink.imagestItems}/${listdatamodel[index].itemsImage}")),
//                     Expanded(
//                         flex: 2,
//                         child: ListTile(
//                           title: Text(listdatamodel[index].itemsName!),
//                           subtitle: Text(listdatamodel[index].categoriesName!),
//                         )),
//                   ],
//                 ),
//               )),
//             ),
//           );
//         });
//   }
// }
