// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controller/adminController.dart';

class AdminAddUnit extends StatefulWidget {
  const AdminAddUnit({super.key});

  @override
  State<AdminAddUnit> createState() => _AdminAddUnitState();
}

class _AdminAddUnitState extends State<AdminAddUnit> {
  final TextEditingController _unitNameController = TextEditingController();

  final TextEditingController _mobileNumberController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String passbook = '';
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getAllRegionalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Unit'),
        backgroundColor: primaryAdminColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Consumer<AdminController>(
              builder: (context, myType, child) {
                return DropDownTextField(
                  initialValue: 'Choose Regional',
                  dropDownList: myType.regionalList,
                  onChanged: (value) {
                    setState(() {
                      passbook = value.value;
                    });
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _unitNameController,
              decoration: const InputDecoration(hintText: 'Unit name'),
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
                    await myType.addUnit(
                        passbookno: passbook,
                        context: context,
                        name: _unitNameController.text,
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
