import 'package:adminkingfashion/core/constant/colors.dart';
import 'package:adminkingfashion/core/funcations/translatefatabase.dart';
import 'package:flutter/material.dart';

class CustomTextFormGolable extends StatelessWidget {
  final String hinttext;
  final String? labeltext;
  final IconData? iconData;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final bool? obscureText;
  final bool? isNumber;
  final void Function()? onTapIcon;
  const CustomTextFormGolable(
      {Key? key,
      required this.hinttext,
      this.labeltext,
      this.iconData,
      required this.mycontroller,
      required this.valid,
      this.obscureText,
      this.onTapIcon,
      this.isNumber})
      : super(key: key);

  @override
  Widget build(Object context) {
    return Container(
        alignment:
            translateDatabase(Alignment.centerRight, Alignment.centerLeft),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          cursorColor: AppColors.thirdColor,
          keyboardType: isNumber!
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          validator: valid,
          controller: mycontroller,
          obscureText:
              obscureText == null || obscureText == false ? false : true,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hoverColor: AppColors.thirdColor,
            hintText: hinttext,
            icon: Icon(
              iconData,
            ),
            hintStyle: const TextStyle(
              fontSize: 14,
            ),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            label: Container(
              margin: const EdgeInsets.symmetric(horizontal: 9),
              child: Text(labeltext!),
            ),
            // suffixIcon: InkWell(
            //   onTap: onTapIcon,
            //   child: Icon(iconData),
            // ),
            // border: const UnderlineInputBorder(
            //     borderSide: BorderSide(
            //   color: AppColors.thirdColor,
            // )),
            focusColor: AppColors.thirdColor,
          ),
        ));
  }
}
