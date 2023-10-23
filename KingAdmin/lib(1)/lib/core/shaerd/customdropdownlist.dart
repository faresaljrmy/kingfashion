import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/material.dart';

class CustomDropdownSearch extends StatefulWidget {
  final String? title;
  final String? hint;
  final String submitbutton;
  final IconData? iconData;
  final TextEditingController? selectedName;
  final TextEditingController selectedId;
  final List<SelectedListItem>? dropDownListData;

  const CustomDropdownSearch(
      {super.key,
      this.title,
      required this.selectedName,
      required this.selectedId,
      required this.dropDownListData,
      required this.submitbutton,
      this.hint,
      required this.iconData});

  @override
  State<CustomDropdownSearch> createState() => _CustomDropdownSearchState();
}

class _CustomDropdownSearchState extends State<CustomDropdownSearch> {
  void onTabDropdownList(context) {
    DropDownState(
      DropDown(
        bottomSheetTitle: Text(
          widget.title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: Text(
          widget.submitbutton == "" ? 'تم' : widget.submitbutton,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: widget.dropDownListData ?? [],
        selectedItems: (List<dynamic> selectedList) {
          SelectedListItem selectedListItem = selectedList[0];
          widget.selectedName!.text = selectedListItem.name;
          widget.selectedId.text = selectedListItem.value.toString();
        },
      ),
    ).showModal(context);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.selectedName,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTabDropdownList(context);
      },
      decoration: InputDecoration(
        icon: Icon(widget.iconData),
        contentPadding:
            const EdgeInsets.only(left: 8, bottom: 0, top: 0, right: 15),
        hintText: widget.selectedName!.text == ""
            ? widget.title
            : widget.selectedName!.text,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            // style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
