// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({Key? key, required this.value, required this.titile})
      : super(key: key);

  final String value;
  final String titile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(titile)),
        const Center(
          child: Text(':  '),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
