// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/admin/view/adminChangeProfit.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminProfit extends StatefulWidget {
  const AdminProfit({super.key});

  @override
  State<AdminProfit> createState() => _AdminProfitState();
}

class _AdminProfitState extends State<AdminProfit> {
  String passbookno = '0';
  String regname = 'null';
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getAllRegionalList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
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
                          regname = value.name;
                        });
                      },
                    ),
                    const Divider(color: Colors.transparent),
                    Consumer<AdminController>(
                      builder: (context, myType, child) {
                        return ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AdminChangeProfit(
                                  passbookno: passbookno,
                                  regname: regname,
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: shadeAdminColor),
                          child: const Text('Get Profit'),
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
