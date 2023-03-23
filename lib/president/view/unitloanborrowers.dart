import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitLoanBorrowers extends StatelessWidget {
  const UnitLoanBorrowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Loan Details'),
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: val.unitloanborrowers(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      padding: const EdgeInsets.all(5),
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data[0]['loandata'].length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['loandata'][index];
                        return Card(
                            child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: double.maxFinite,
                              color: shadeprimaryColor,
                              child: const Center(child: Text('LOAN RECORD')),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Items(
                                      value: data['membername'],
                                      titile: "Name"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(value: data['ldate'], titile: "Date"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['amount'],
                                      titile: "Loan Amount"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(value: data['bal'], titile: "Balance"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['period'],
                                      titile: "Loan Period"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['interest'],
                                      titile: "Interest"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['installment'],
                                      titile: "Intallment"),
                                ],
                              ),
                            ),
                            const Divider(),
                            CupertinoButton(
                                child: const Text('Close Loan'),
                                onPressed: () {
                                  val.closeunitloan(data['loanid'], context);
                                })
                          ],
                        ));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('no data found'),
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
