// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitChatScreen extends StatelessWidget {
  UnitChatScreen(
      {super.key,
      required this.option,
      required this.number,
      required this.name,
      required this.passbook});
  String number;
  String passbook;
  String name;
  int option;
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message to $name'),
        backgroundColor: primaryUnitColor,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Divider(color: Colors.transparent),
              /*  Text(
                'Send message to $name',
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ), */
              const Divider(color: Colors.transparent),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'this field cannot be empty !';
                  } else if (value.length <= 1) {
                    return 'message should have atleast 2 letters !';
                  }
                  return null;
                },
                maxLines: 8,
                controller: _messageController,
              ),
              const Divider(),
              const Divider(color: Colors.transparent),
              SizedBox(
                height: 40,
                width: double.maxFinite,
                child: Consumer<UnitControll>(builder: (context, val, child) {
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: shadeUnitColor),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await val.unitSendMessagetoShg(
                              context: context,
                              message: _messageController.text,
                              name: name,
                              shgpassbook: passbook);
                        }
                      },
                      child:
                          Text(option == 1 ? 'Send To $name' : 'Send To All'));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
