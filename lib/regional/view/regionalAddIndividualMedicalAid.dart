import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class AddIndividualMedicalAid extends StatefulWidget {
  const AddIndividualMedicalAid({super.key});

  @override
  State<AddIndividualMedicalAid> createState() =>
      _AddIndividualMedicalAidState();
}

class _AddIndividualMedicalAidState extends State<AddIndividualMedicalAid> {
  TextEditingController nameController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryRegionColor,
        title: const Text('Individual Medical Aid'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'required';
                  } else {
                    return '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Name',
                  icon: Icon(
                    Icons.person,
                    color: primaryRegionColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'required';
                  } else {
                    return '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Place',
                  icon: Icon(
                    Icons.location_city,
                    color: primaryRegionColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'required';
                  } else {
                    return '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Mobile Number',
                  icon: Icon(
                    Icons.phone,
                    color: primaryRegionColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                validator: (value) {
                  if (value == '' || value!.isEmpty) {
                    return 'required';
                  } else {
                    return '';
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Amount',
                  icon: Icon(
                    Icons.currency_rupee,
                    color: primaryRegionColor,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<RegionalController>(
                builder: (context, myType, child) {
                  return ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        myType.addIndMedicalAid(
                            context: context,
                            name: nameController.text,
                            mobile: numberController.text,
                            place: placeController.text,
                            amount: amountController.text);
                      } else {}
                    },
                    child: const Text('Add Medical Aid'),
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
