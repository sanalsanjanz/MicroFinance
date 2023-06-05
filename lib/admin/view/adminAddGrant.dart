// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminAddGrant extends StatefulWidget {
  const AdminAddGrant({super.key});

  @override
  State<AdminAddGrant> createState() => _AdminAddGrantState();
}

class _AdminAddGrantState extends State<AdminAddGrant> {
  TextEditingController grantType = TextEditingController();

  TextEditingController grantAmount = TextEditingController();

  TextEditingController dateInput2 = TextEditingController();

  String passbookno = '0';
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getAllRegionalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grant'),
        backgroundColor: primaryAdminColor,
      ),
      body: Consumer<AdminController>(builder: (context, val, child) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropDownTextField(
                      initialValue: 'Choose Regional',
                      dropDownList: val.regionalList,
                      onChanged: (value) {
                        setState(() {
                          passbookno = value.value;
                        });
                      },
                    ),
                    TextField(
                      controller: grantType,
                      decoration: const InputDecoration(
                        hintText: 'Enter grant type',
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: grantAmount,
                      decoration:
                          const InputDecoration(hintText: 'Enter grant amount'),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(15),
                      // height: MediaQuery.of(context).size.width / 3,
                      child: TextField(
                        controller: dateInput2,
                        decoration: const InputDecoration(
                            icon: Icon(Icons.calendar_today),
                            labelText: " Date"),
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
                    Consumer<AdminController>(
                      builder: (context, myType, child) {
                        return ElevatedButton(
                          onPressed: () async {
                            await myType.addGrant(
                                context: context,
                                regionpassbookno: passbookno,
                                type: grantType.text,
                                date: dateInput2.text,
                                amount: grantAmount.text);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: shadeAdminColor),
                          child: const Text('Add'),
                        );
                      },
                    )
                  ],
                ),
                const Divider(color: Colors.transparent),
              ],
            ));
      }),
    );
  }
}
