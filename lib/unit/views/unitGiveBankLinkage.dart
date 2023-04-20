// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';

class UnitGiveBankLinkageMember extends StatelessWidget {
  UnitGiveBankLinkageMember({super.key});
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Give BankLinkage'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Enter an amount';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Enter Amount',
                    icon: Icon(Icons.attach_money_outlined)),
              ),
              const Divider(color: Colors.transparent),
              TextFormField(
                validator: (value) {
                  if (value == null || value == '') {
                    return '* this field is required';
                  } else if (int.parse(value) > 12 || int.parse(value) == 0) {
                    return 'enter a valid range';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'Enter Period/Month',
                  icon: Icon(Icons.date_range),
                ),
              ),
              const Divider(color: Colors.transparent),
              TextFormField(
                validator: (value) {
                  return null;
                },
                readOnly: true,
                decoration: const InputDecoration(
                    hintText: '12% Interest/year',
                    icon: Icon(Icons.interests),
                    hintStyle: TextStyle(color: Colors.red)),
              ),
              const Divider(color: Colors.transparent),
              TextFormField(
                validator: (value) {
                  if (value == null || value == '') {
                    return '* this field is required';
                  } else if (int.parse(value) > 30 || int.parse(value) == 0) {
                    return 'enter a valid range';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: 'Payment Date (1-30)',
                    icon: Icon(Icons.date_range_outlined)),
              ),
              const Divider(color: Colors.transparent),
              ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {}
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryUnitColor,
                  shape: const StadiumBorder(),
                ),
                child: const Text('Pay Amount'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
