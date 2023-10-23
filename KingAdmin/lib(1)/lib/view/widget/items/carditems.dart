import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CardItemsView extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onedit;
  final void Function()? ondelete;
  final String? imageurl;
  final String? title;
  final String? date;

  const CardItemsView(
      {super.key,
      required this.onTap,
      required this.title,
      required this.date,
      this.onedit,
      this.ondelete,
      required this.imageurl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: InkWell(
        onTap: () {},
        child: Card(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: imageurl!,
                width: 50,
              ),
            ),
            // Image.asset(AppImageAsset.categories,width: 90,),
            // SizedBox(height: 10,),

            Expanded(
                flex: 3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      date!,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: onedit,
                            icon: const Icon(
                              Icons.edit,
                              color: AppColors.thirdColor,
                            )),
                        IconButton(
                            onPressed: ondelete,
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.red,
                            )),
                      ],
                    ),
                  ],
                ))
          ],
        )),
      ),
    );
  }
}
