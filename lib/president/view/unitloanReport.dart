// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitLoanReport extends StatefulWidget {
  const UnitLoanReport({super.key});

  @override
  State<UnitLoanReport> createState() => _UnitLoanReportState();
}

class _UnitLoanReportState extends State<UnitLoanReport> {
  TextEditingController date1 = TextEditingController();
  TextEditingController date2 = TextEditingController();
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        toolbarHeight: MediaQuery.of(context).size.height / 3,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer<PresidentController>(builder: (context, val, ch) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              // height: MediaQuery.of(context).size.width / 3,ss
                              child: TextField(
                                controller: date1,
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
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);

                                    setState(() {
                                      date1.text = formattedDate;
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
                                controller: date2,
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
                                        DateFormat('yyyy-MM-dd')
                                            .format(pickedDate);
                                    //print(formattedDate);
                                    setState(() {
                                      date2.text = formattedDate;
                                    });
                                  } else {}
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                    Consumer<PresidentController>(builder: (context, val, ch) {
                      return Row(
                        children: [
                          const Expanded(
                            child: Text('Choose Type'),
                          ),
                          Expanded(
                            child: DropDownTextField(
                              onChanged: (value) {
                                val.settypeofreport(value.value);
                              },
                              dropDownList: const [
                                DropDownValueModel(name: 'Open', value: 'Open'),
                                DropDownValueModel(
                                    name: 'Closed', value: 'Closed'),
                                DropDownValueModel(name: 'Both', value: 'Both'),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    Consumer<PresidentController>(builder: (context, val, chi) {
                      return Row(
                        children: [
                          const Expanded(
                            child: Text('Choose Member'),
                          ),
                          Expanded(
                            child: DropDownTextField(
                              dropDownList: val.memmbers,
                              onChanged: (value) {
                                val.setmembid(value.value);
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer<PresidentController>(builder: (context, val, chi) {
                      return ElevatedButton(
                        onPressed: () async {
                          await val.unitloanreport(
                              from: date1.text, to: date2.text);
                        },
                        child: const Text("Search"),
                      );
                    })
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
      body: Consumer<PresidentController>(builder: (context, val, chi) {
        return Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Expanded(
                      child: FutureBuilder(
                          future: val.unitloanreport(
                              from: date1.text, to: date2.text),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data[0]['message'] != "no datas") {
                                return ListView.separated(
                                    padding: const EdgeInsets.all(5),
                                    itemBuilder: (context, index) {
                                      var data =
                                          snapshot.data[index]['loandata'][0];
                                      return Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(data['membername']
                                                    .toString()
                                                    .toUpperCase()),
                                              ),
                                              const Divider(),
                                              Items(
                                                  value: data['ldate'],
                                                  titile: 'Loan Date'),
                                              const Divider(),
                                              Items(
                                                  value: data['amount'],
                                                  titile: 'Loan Amount'),
                                              const Divider(),
                                              Items(
                                                  value: data['bal'],
                                                  titile: 'Loan Balance'),
                                              const Divider(),
                                              Items(
                                                  value: data['period'],
                                                  titile: 'Loan Period'),
                                              const Divider(),
                                              Items(
                                                  value: data['interest'],
                                                  titile: 'Loan Interest'),
                                              const Divider(),
                                              Items(
                                                  value: data['moninterest'],
                                                  titile: 'Monthly Interest'),
                                              const Divider(),
                                              Items(
                                                  value: data['totalinterest'],
                                                  titile: 'Total Interest'),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        const Divider(),
                                    itemCount:
                                        snapshot.data[0]['loandata'].length);
                              } else {
                                return const Center(
                                  child: Text('No Records'),
                                );
                              }
                            } else {
                              return Center(
                                  child:
                                      SpinKitFadingCircle(color: primaryColor));
                            }
                          })),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
