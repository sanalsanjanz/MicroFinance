// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controller/adminController.dart';

class AdminAddRegional extends StatelessWidget {
  AdminAddRegional({super.key});
  final TextEditingController _regionalNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Regional'),
        backgroundColor: primaryAdminColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _regionalNameController,
              decoration: const InputDecoration(hintText: 'Regional name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _mobileNumberController,
              decoration: const InputDecoration(hintText: 'Mobile number'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 10,
            ),
            Consumer<AdminController>(
              builder: (context, myType, child) {
                return ElevatedButton(
                  onPressed: () async {
                    await myType.addRegional(
                        context: context,
                        name: _regionalNameController.text,
                        number: _mobileNumberController.text,
                        password: _passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: shadeAdminColor),
                  child: const Text('Add'),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
