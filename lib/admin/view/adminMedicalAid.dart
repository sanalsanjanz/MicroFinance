import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminMedicalAid extends StatelessWidget {
  AdminMedicalAid({super.key});

  var unitpassbook = '';

  TextEditingController nameController = TextEditingController();

  TextEditingController placeController = TextEditingController();

  TextEditingController numberController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Aid'),
        backgroundColor: primaryAdminColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: MediaQuery.of(context).size.height / 4,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: placeController,
                decoration: const InputDecoration(hintText: 'Place'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: numberController,
                decoration: const InputDecoration(
                  hintText: 'Number',
                  // suffixText: 'Month',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              const Divider(color: Colors.transparent),
              Consumer<AdminController>(
                builder: (context, myType, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      await myType.addMedicalAid(
                          context: context,
                          name: nameController.text,
                          place: placeController.text,
                          mobile: numberController.text,
                          amount: amountController.text);
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
      ),
    );
  }
}
