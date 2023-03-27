// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class PresidentOptionalCard extends StatelessWidget {
  bool visibility;
  String titile;
  String subtitle;
  Color? color;
  void Function()? onTap;
  String letter;

  PresidentOptionalCard({
    super.key,
    required this.visibility,
    required this.titile,
    required this.subtitle,
    required this.letter,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibility,
        child: InkWell(
          onTap: onTap,
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  letter,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w900),
                ),
              ),
              title: Text(titile),
              subtitle: Text(subtitle),
              trailing: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ),
        ));
  }
}
