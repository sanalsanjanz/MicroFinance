// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminBankLinkage extends StatefulWidget {
  AdminBankLinkage({super.key});

  @override
  State<AdminBankLinkage> createState() => _AdminBankLinkageState();
}

class _AdminBankLinkageState extends State<AdminBankLinkage> {
  TextEditingController amountControll = TextEditingController();

  TextEditingController periodControll = TextEditingController();

  TextEditingController dateInput2 = TextEditingController();
  String passbookNo = '';
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getAllRegionalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Linkage'),
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
              Consumer<AdminController>(
                builder: (context, myType, child) {
                  return DropDownTextField(
                    initialValue: 'Choose Regional',
                    dropDownList: myType.regionalList,
                    onChanged: (value) {
                      setState(() {
                        passbookNo = value.value;
                      });
                    },
                  );
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: amountControll,
                decoration: const InputDecoration(
                  hintText: 'amount',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.number,
                controller: periodControll,
                decoration: const InputDecoration(hintText: 'Period'),
              ),
              const SizedBox(height: 8),
              const TextField(
                decoration: InputDecoration(
                  hintText: '12 % interest',
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(15),
                // height: MediaQuery.of(context).size.width / 3,
                child: TextField(
                  controller: dateInput2,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), labelText: " Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime(2100));
                    if (pickedDate != null) {
                      //print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      //print(formattedDate);
                      setState(() {
                        dateInput2.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              const Divider(color: Colors.transparent),
              Consumer<AdminController>(
                builder: (context, myType, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      await myType.addBankLinkage(
                          context: context,
                          amount: amountControll.text,
                          period: periodControll.text,
                          date: dateInput2.text,
                          regionpassbookno: passbookNo);
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
