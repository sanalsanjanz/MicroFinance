// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitIndividualMedicalAid extends StatelessWidget {
  UnitIndividualMedicalAid({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Individual Medical Aid'),
        backgroundColor: primaryUnitColor,
      ),
      body: Column(
        children: [
          Card(
            child: SizedBox(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Divider(color: Colors.transparent),
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.person, color: primaryColor),
                          hintText: 'Name'),
                    ),
                    const Divider(color: Colors.transparent),
                    TextField(
                      controller: placeController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.location_on, color: primaryColor),
                          hintText: 'Place'),
                    ),
                    const Divider(color: Colors.transparent),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: numberController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.phone, color: primaryColor),
                          hintText: 'Mobile Number'),
                    ),
                    const Divider(color: Colors.transparent),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      decoration: InputDecoration(
                          icon:
                              Icon(Icons.monetization_on, color: primaryColor),
                          hintText: 'Amount'),
                    ),
                    const Divider(color: Colors.transparent),
                    const Divider(),
                    Consumer<UnitControll>(builder: (context, value, child) {
                      return SizedBox(
                        width: 200,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: shadeUnitColor),
                            onPressed: () async {
                              await value.addMedicalAidIndividual(
                                  context: context,
                                  name: nameController.text,
                                  place: placeController.text,
                                  mobile: numberController.text,
                                  amount: amountController.text);
                            },
                            child: const Text('Add')),
                      );
                    })
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
