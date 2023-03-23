// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import '../../widgets/choicechip.dart';
import '../controller/presidenthomecontroll.dart';

class PresidentReports extends StatefulWidget {
  const PresidentReports({super.key});

  @override
  State<PresidentReports> createState() => _PresidentReportsState();
}

class _PresidentReportsState extends State<PresidentReports> {
  final TextEditingController date1 = TextEditingController();
  final TextEditingController date2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false).memmbers.isEmpty
        ? Provider.of<PresidentController>(context, listen: false)
            .memberlistDrop()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Consumer<PresidentController>(builder: (context, val, child) {
          return Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Card(
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('Choose Member'),
                    ),
                    Expanded(
                      child: DropDownTextField(
                        initialValue: 'Choose name',
                        dropDownList: val.memmbers,
                        onChanged: (value) {
                          val.setmembid(value.value);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
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
                            date1.text = formattedDate;
                          });
                        } else {}
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          // height: MediaQuery.of(context).size.width / 3,ss
                          child: TextField(
                            controller: date1,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
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
                                  date1.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
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
                            date2.text = formattedDate;
                          });
                        } else {}
                      },
                      child: Card(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          // height: MediaQuery.of(context).size.width / 3,
                          child: TextField(
                            controller: date2,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
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
                                  date2.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              const Text(
                'Which reports do you want to see ?',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChoiceChip(
                    label: 'Attendance',
                    isSelected: val.showattendanceReport, // value.newuser,
                    onSelected: (values) {
                      val.setattendanceReport();
                      //value.setnewUser();
                    },
                  ),
                  const VerticalDivider(),
                  CustomChoiceChip(
                    label: 'Festival Fund',
                    isSelected: val.showfestivalfundReport, // value.newuser,
                    onSelected: (values) {
                      val.setfestivalfundReport();
                      //value.setnewUser();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomChoiceChip(
                    label: 'Sess Fund',
                    isSelected: val.showsessfundReport, // value.newuser,
                    onSelected: (values) {
                      val.setsessfundReport();
                      //value.setnewUser();
                    },
                  ),
                  const VerticalDivider(),
                  CustomChoiceChip(
                    label: 'Loan Payment',
                    isSelected: val.showloanReport, // value.newuser,
                    onSelected: (values) {
                      val.setloanReport();
                      //value.setnewUser();
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomChoiceChip(
                    label: 'Expense',
                    isSelected: val.showexpenseReport, // value.newuser,
                    onSelected: (values) {
                      val.setexpenseReport();
                      //value.setnewUser();
                    },
                  ),
                  const VerticalDivider(),
                  CustomChoiceChip(
                    label: 'Savings',
                    isSelected: val.showsavingsReport, // value.newuser,
                    onSelected: (values) {
                      val.setSavingsReport();
                      //value.setnewUser();
                    },
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: const StadiumBorder(),
                ),
                onPressed: () {},
                child: const Text('Get Reports'),
              ),
              const Expanded(child: SizedBox()),
            ],
          );
        }),
      ),
    );
  }
}
