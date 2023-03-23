// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class CustomChoiceChip extends StatelessWidget {
  CustomChoiceChip(
      {Key? key,
      required this.isSelected,
      required this.onSelected,
      required this.label})
      : super(key: key);

  bool isSelected;
  void Function(bool)? onSelected;
  String label;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
        padding: const EdgeInsets.only(right: 8),
        labelPadding: const EdgeInsets.all(2),
        pressElevation: 2,
        onSelected: onSelected,
        avatar: Checkbox(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          checkColor: Colors.transparent,
          fillColor:
              MaterialStateProperty.all(Colors.blueGrey[500]), //kprimarycolor
          onChanged: (value) => isSelected = !isSelected,
          value: isSelected,
        ),
        selectedColor: const Color.fromARGB(255, 204, 197,
            197), //  const Color.fromARGB(255, 97, 175, 184), //primaryColor[100],
        disabledColor: const Color.fromARGB(131, 106, 105, 105),
        label: Text(label),
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 7, 7, 7), fontWeight: FontWeight.bold),
        selected: isSelected);
  }
}
