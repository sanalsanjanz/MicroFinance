// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../../widgets/itemsCard.dart';
import '../controllers/memberController.dart';

class MemberReport extends StatefulWidget {
  MemberReport({required this.presid});
  String presid;
  @override
  State<MemberReport> createState() => _MemberReportState();
}

class _MemberReportState extends State<MemberReport> {
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  @override
  void initState() {
    dateInput1.text = "";
    dateInput2.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: const Text("Report"), backgroundColor: primaryColor),
      body: Column(
        children: [
          Consumer<MemberHomeController>(builder: (context, val, ch) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.width / 3,ss
                    child: TextField(
                      controller: dateInput1,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "From Date"),
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
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.width / 3,
                    child: TextField(
                      controller: dateInput2,
                      decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today),
                          labelText: "To Date"),
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
                ),
              ],
            );
          }),
          Consumer<MemberHomeController>(builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(15),
              // height: 45,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: shadeprimaryColor),
                onPressed: () {
                  value.getReport(
                      presid: widget.presid,
                      date1: dateInput1.text,
                      date2: dateInput2.text);
                },
                child: const Text("Get Report"),
              ),
            );
          }),
          Expanded(child: Consumer<MemberHomeController>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getReport(
                    presid: 'presid',
                    date1: dateInput1.text,
                    date2: dateInput2.text),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Items(
                              value: data[0]['sambadhyam'].toString(),
                              titile: "sambadhyam"),
                          Items(
                              value: data[1]['no_of_loan'].toString(),
                              titile: "Number of loans"),
                          Items(
                              value: data[2]['paid_loan_amt'].toString(),
                              titile: "Paid loan amount"),
                          Items(
                              value: data[3]['interest_amt'].toString(),
                              titile: "Interest Amount"),
                          Items(
                              value: data[4]['bal'].toString(),
                              titile: "Balance"),
                          Items(
                              value: data[5]['lamt'].toString(),
                              titile: "Loan Amount"),
                          Items(
                              value: data[6]['no_of_bloan'].toString(),
                              titile: "Number of bank loan"),
                          Items(
                              value: data[7]['bank_paid_loan_amt'].toString(),
                              titile: "Paid bank loan amount"),
                          Items(
                              value: data[8]['bank_bal'].toString(),
                              titile: "Bank Balance"),
                          Items(
                              value: data[9]['bank_lamt'].toString(),
                              titile: "Bank Amount"),
                          Items(
                              value: data[10]['from'].toString(),
                              titile: "From"),
                          Items(value: data[11]['to'].toString(), titile: "To")
                        ],
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No results"),
                    );
                  }
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
