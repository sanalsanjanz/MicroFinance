// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitAddExternalLoan extends StatefulWidget {
  const UnitAddExternalLoan({super.key});

  @override
  State<UnitAddExternalLoan> createState() => _UnitAddExternalLoanState();
}

class _UnitAddExternalLoanState extends State<UnitAddExternalLoan> {
  final TextEditingController dateInput1 = TextEditingController();

  final TextEditingController amount = TextEditingController();

  final TextEditingController period = TextEditingController();
  final TextEditingController interest = TextEditingController();
  final TextEditingController paydate = TextEditingController();
  Widget space = const SizedBox(
    height: 9,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getExternalMember(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data[0]['memberdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['memberdata'][index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          showBottomSheet(
                            context: context,
                            builder: (context) {
                              return Card(
                                color: Colors.green[50],
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      const Center(
                                        child: Text(
                                          'Add External Loan',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                      const Divider(),
                                      Text(data['membername']
                                          .toString()
                                          .toUpperCase()),
                                      const Divider(),
                                      /*  Container(
                                        padding: const EdgeInsets.all(15),
                                        // height: MediaQuery.of(context).size.width / 3,ss
                                        child: TextField(
                                          controller: dateInput1,
                                          decoration: const InputDecoration(
                                              icon: Icon(Icons.calendar_today),
                                              labelText: "Choose Date"),
                                          readOnly: true,
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
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
                                                dateInput1.text = formattedDate;
                                              });
                                            } else {}
                                          },
                                        ),
                                      ), */
                                      space,
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: amount,
                                        decoration: const InputDecoration(
                                            icon: Icon(
                                                Icons.attach_money_outlined),
                                            hintText: 'Loan Amount'),
                                      ),
                                      space,
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: period,
                                        decoration: const InputDecoration(
                                            suffix: Text('/month'),
                                            icon: Icon(Icons.date_range),
                                            hintText: 'Period'),
                                      ),
                                      space,
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: interest,
                                        decoration: const InputDecoration(
                                            icon: Icon(Icons.percent),
                                            suffix: Text('%'),
                                            hintText: 'Interest'),
                                      ),
                                      space,
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        controller: paydate,
                                        decoration: const InputDecoration(
                                            suffix: Text('(1-30)'),
                                            icon: Icon(Icons.date_range),
                                            hintText: 'Pay Date'),
                                      ),
                                      space,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          const VerticalDivider(),
                                          TextButton(
                                            onPressed: () async {
                                              await val.addUnitExternalLoan(
                                                  context: context,
                                                  amount: amount.text,
                                                  period: period.text,
                                                  interest: interest.text,
                                                  id: data['memberid'],
                                                  status: 'no',
                                                  date: paydate.text);
                                            },
                                            child: const Text('Give Loan'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Tap to add loan'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['membername']),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Lottie.asset('assets/notfound.json'),
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
