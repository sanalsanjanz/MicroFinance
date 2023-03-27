// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../../widgets/itemsCard.dart';
import '../controllers/memberController.dart';

class MemberMonthlyCollection extends StatefulWidget {
  MemberMonthlyCollection({required this.presid});
  String presid;
  @override
  State<MemberMonthlyCollection> createState() =>
      _MemberMonthlyCollectionState();
}

class _MemberMonthlyCollectionState extends State<MemberMonthlyCollection> {
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();

  @override
  void initState() {
    dateInput1.text = "";
    dateInput2.text = "";
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    dateInput1.dispose();
    dateInput2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Monthly Collection"),
          backgroundColor: memberPrimary),
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
          /* Consumer<MemberHomeController>(builder: (context, value, child) {
            return Container(
              margin: const EdgeInsets.all(15),
              // height: 45,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: shadeprimaryColor),
                onPressed: () {},
                child: const Text("Get Report"),
              ),
            );
          }), */
          Expanded(child: Consumer<MemberHomeController>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.getMothlyCollection(
                    date1: dateInput1.text, date2: dateInput2.text),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data[0]['moncolldata'].length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[0]['moncolldata'][index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Items(
                                      value: data['amt'].toString(),
                                      titile: "Amount"),
                                  const SizedBox(height: 8),
                                  Items(
                                      value: data['date'].toString(),
                                      titile: "Date"),
                                ],
                              ),
                            ),
                          );
                        });
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
