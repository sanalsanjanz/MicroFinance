import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';

class UnitHomeCard extends StatelessWidget {
  UnitHomeCard(
      {super.key,
      required this.title,
      required this.description,
      required this.icon,
      this.onTap});
  String icon;
  void Function()? onTap;
  String title;
  String description;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: onTap,
      child: Card(
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.all(15),
          width: double.maxFinite,
          // height: 150,
          // color: primaryUnitColor,
          child: Column(
            children: [
              const Divider(color: Colors.transparent),
              Image(
                height: 40,
                color: primaryUnitColor,
                image: AssetImage(
                  icon,
                ),
              ),
              const Divider(color: Colors.transparent),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(188, 0, 0, 0)),
              ),
              const Divider(),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const Divider(color: Colors.transparent),
            ],
          ),
        ),
      ),
    ));
  }
}
