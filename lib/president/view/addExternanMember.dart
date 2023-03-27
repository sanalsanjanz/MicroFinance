// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import '../controller/presidenthomecontroll.dart';

class AddExternalMember extends StatelessWidget {
  AddExternalMember({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<PresidentController>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text('Enter Details'),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: numberController,
              decoration: const InputDecoration(hintText: 'Phone number'),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () async {
                await value.addPExternalMember(context,
                    number: numberController.text, mailid: nameController.text);
              },
              child: const Text("Add Member"),
            ),
          ],
        ),
      );
    }));
  }
}
