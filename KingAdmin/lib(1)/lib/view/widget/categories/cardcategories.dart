import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/constant/imgaeasset.dart';
import 'package:adminkingfashion/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardCategoriesView extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onedit;
  final void Function()? ondelete;
  final String? url;
  final String? title;
  final String? date;

  const CardCategoriesView(
      {super.key,
      required this.onTap,
      required this.url,
      required this.title,
      required this.date,
      this.onedit,
      this.ondelete});

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
            (url != null && url != "empty" && url!.isNotEmpty)
                ? Expanded(
                    child: SvgPicture.network(
                      "${AppLink.imagestCategories}/$url",
                      width: 50,
                      color: AppColors.thirdColor,
                    ),
                  )
                : Expanded(
                    child: Image.asset(
                      AppImageAsset.categories,
                      width: 50,
                    ),
                  ),
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
