// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitPaySavingsInterest extends StatefulWidget {
  UnitPaySavingsInterest({super.key, required this.passbook});
  String passbook;

  @override
  State<UnitPaySavingsInterest> createState() => _UnitPaySavingsInterestState();
}

class _UnitPaySavingsInterestState extends State<UnitPaySavingsInterest> {
  TextEditingController dateInput1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interest'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.fetchYearlyInterestUnit(
              context: context, shgpassbookno: widget.passbook),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(5),
                  physics: const BouncingScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    var data = snapshot.data;
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Divider(color: Colors.transparent),
                          TextFormField(
                            /*    initialValue:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()), */
                            controller: dateInput1,
                            decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today),
                                labelText: "Choose Date"),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now());

                              if (pickedDate != null) {
                                //print(pickedDate);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);

                                setState(() {
                                  dateInput1.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                          const Divider(color: Colors.transparent),
                          const Divider(color: Colors.transparent),
                          Items(
                              value: data[0]['interest'].toString(),
                              titile: 'Interest'),
                          const Divider(color: Colors.transparent),
                          Items(
                              value: data[1]['shg_passbook_no'],
                              titile: 'Passbook No'),
                          const Divider(color: Colors.transparent),
                          SizedBox(
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: shadeUnitColor),
                              onPressed: () async {
                                await val.unitpaySavingsInterestToRegion(
                                    context: context,
                                    date: dateInput1.text,
                                    amount: data[0]['interest'].toString(),
                                    passbookno: data[1]['shg_passbook_no']);
                              },
                              child: const Text('PAY'),
                            ),
                          ),
                          const Divider(color: Colors.transparent),
                        ],
                      ),
                    ));
                  },
                );
              } else {
                return const Center(
                  child: Text('No SHG Found'),
                );
              }
            } else {
              return Center(
                child: SpinKitFadingCircle(color: primaryColor),
              );
            }
          },
        );
      }),
    );
  }
}
