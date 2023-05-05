// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

import 'package:sacco_management/widgets/itemsCard.dart';

class UnitExternalLoanBorrowersDetails extends StatefulWidget {
  // String unitid;
  UnitExternalLoanBorrowersDetails({required this.memberid});
  String memberid;

  @override
  State<UnitExternalLoanBorrowersDetails> createState() =>
      _UnitExternalLoanBorrowersDetailsState();
}

class _UnitExternalLoanBorrowersDetailsState
    extends State<UnitExternalLoanBorrowersDetails> {
  Widget space = const SizedBox(
    height: 9,
  );
  final TextEditingController dateInput1 = TextEditingController();
  final TextEditingController amount = TextEditingController();
  final TextEditingController panalty = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.unitExternalLoanBorrowersDetails(
                context: context, memberid: widget.memberid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data[0]['memberdata'] != 'no datas') {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['memberdata'][index];
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['member_name']
                                        .toString()
                                        .toUpperCase(),
                                    style: title,
                                  ),
                                  space,
                                  Items(
                                      value: data['ldate'],
                                      titile: 'Loan Date'),
                                  space,
                                  Items(
                                      titile: 'Loan Amount',
                                      value: data['amount']),
                                  space,
                                  Items(value: data['bal'], titile: 'Balance'),
                                  space,
                                  /*   Items(
                                      value: data['interest'],
                                      titile: 'Loan Interest'),
                                  space, */
                                  Items(
                                      value: data['period'] + '/months',
                                      titile: 'Loan Period'),
                                  space,
                                  Items(
                                      value: data['interest'] + '  %',
                                      titile: 'Interest'),
                                  space,
                                  Items(
                                      value: data['installment'],
                                      titile: 'Installment'),
                                  const Divider(),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                            onPressed: () {
                                              showBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Card(
                                                    color: Colors.green[50],
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          const Divider(
                                                            color: Colors
                                                                .transparent,
                                                          ),
                                                          const Center(
                                                            child: Text(
                                                              'Loan Updation',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                          const Divider(),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15),
                                                            // height: MediaQuery.of(context).size.width / 3,ss
                                                            child: TextField(
                                                              controller:
                                                                  dateInput1,
                                                              decoration: const InputDecoration(
                                                                  icon: Icon(Icons
                                                                      .calendar_today),
                                                                  labelText:
                                                                      "Choose Date"),
                                                              readOnly: true,
                                                              onTap: () async {
                                                                DateTime? pickedDate = await showDatePicker(
                                                                    context:
                                                                        context,
                                                                    initialDate:
                                                                        DateTime
                                                                            .now(),
                                                                    firstDate:
                                                                        DateTime(
                                                                            2000),
                                                                    lastDate:
                                                                        DateTime
                                                                            .now());

                                                                if (pickedDate !=
                                                                    null) {
                                                                  //print(pickedDate);
                                                                  String
                                                                      formattedDate =
                                                                      DateFormat(
                                                                              'yyyy-MM-dd')
                                                                          .format(
                                                                              pickedDate);

                                                                  setState(() {
                                                                    dateInput1
                                                                            .text =
                                                                        formattedDate;
                                                                  });
                                                                } else {}
                                                              },
                                                            ),
                                                          ),
                                                          space,
                                                          TextField(
                                                            controller: amount,
                                                            decoration: const InputDecoration(
                                                                icon: Icon(Icons
                                                                    .attach_money_outlined),
                                                                hintText:
                                                                    'Pay Amount'),
                                                          ),
                                                          space,
                                                          TextField(
                                                            controller: panalty,
                                                            decoration: const InputDecoration(
                                                                icon: Icon(Icons
                                                                    .percent),
                                                                hintText:
                                                                    'Penalty'),
                                                          ),
                                                          space,
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              const VerticalDivider(),
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  await value.payUnitExternalLoan(
                                                                      data[
                                                                          'loanid'],
                                                                      context,
                                                                      amount
                                                                          .text,
                                                                      panalty
                                                                          .text,
                                                                      dateInput1
                                                                          .text);
                                                                },
                                                                child:
                                                                    const Text(
                                                                        'Add'),
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
                                            child: const Text('Pay Loan')),
                                      ),
                                      const VerticalDivider(),
                                      Expanded(
                                        child: OutlinedButton(
                                          onPressed: () async {
                                            await value.closeUnitExternalLoan(
                                                context, data['loanid']);
                                          },
                                          child: const Text('Close Loan'),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      //   separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data[0]['memberdata'].length);
                } else {
                  return Center(child: Lottie.asset('assets/notfound.json'));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: shadeprimaryColor,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
