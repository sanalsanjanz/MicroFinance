// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitLoanPayment extends StatelessWidget {
  UnitLoanPayment({super.key});
  TextEditingController loanamountController = TextEditingController();
  TextEditingController loanpanality = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Loan Payment'),
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            const SizedBox(
              height: 10,
            ),
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
                              color: const Color.fromARGB(255, 251, 243, 243),
                              child: Center(child: Text(data['membername'])),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  /*     Items(
                                      value: data['membername'],
                                      titile: "Name"), */
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
                                      value: data['paydate'],
                                      titile: "Payment Date"),
                                ],
                              ),
                            ),
                            const Divider(),
                            Row(
                              children: [
                                const VerticalDivider(),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: shadeprimaryColor),
                                        child: const Text('Pay Interest'),
                                        onPressed: () async {
                                          await val.interestpayment(
                                              data['loanid'],
                                              data['interest'],
                                              data['period'],
                                              data['bal']);
                                          showBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                  ),
                                                ),
                                                /* 
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height, */
                                                padding:
                                                    const EdgeInsets.all(20),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                          data['membername']
                                                              .toString()
                                                              .toUpperCase()),
                                                    ),
                                                    const Divider(),
                                                    Items(
                                                        value:
                                                            val.totalinterest,
                                                        titile:
                                                            'Total Interest'),
                                                    Items(
                                                        value: val
                                                            .monthlyinterest
                                                            .toString(),
                                                        titile:
                                                            'Interest Per Month'),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        const VerticalDivider(),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await val.addunitloaninterestpayment(
                                                                  context:
                                                                      context,
                                                                  loanid: data[
                                                                      'loanid']);
                                                            },
                                                            child: const Text(
                                                                'Update'))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                ),
                                const VerticalDivider(),
                                Expanded(
                                  child: SizedBox(
                                    height: 35,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: shadeprimaryColor),
                                        child: const Text('Pay Loan'),
                                        onPressed: () {
                                          showBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: primaryColor,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(50),
                                                    topRight:
                                                        Radius.circular(50),
                                                  ),
                                                ),
                                                /* 
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height, */
                                                padding:
                                                    const EdgeInsets.all(20),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        IconButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            icon: const Icon(
                                                                Icons.close))
                                                      ],
                                                    ),
                                                    Center(
                                                      child: Text(
                                                          data['membername']
                                                              .toString()
                                                              .toUpperCase()),
                                                    ),
                                                    const Divider(),
                                                    Items(
                                                        value: data['bal'],
                                                        titile: 'Balnace'),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                              'Pay Amount'),
                                                        ),
                                                        const Center(
                                                          child: Text(':'),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                loanamountController,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        'type here'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                              'Panality (%)'),
                                                        ),
                                                        const Center(
                                                          child: Text(':'),
                                                        ),
                                                        Expanded(
                                                          child: TextField(
                                                            controller:
                                                                loanpanality,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                                    hintText:
                                                                        'type here'),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const Divider(),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                              'Cancel'),
                                                        ),
                                                        const VerticalDivider(),
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await val.addunitloanpayment(
                                                                  context:
                                                                      context,
                                                                  amount:
                                                                      loanamountController
                                                                          .text,
                                                                  loanid: data[
                                                                      'loanid'],
                                                                  panality:
                                                                      loanpanality
                                                                          .text);
                                                            },
                                                            child: const Text(
                                                                'Update'))
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        }),
                                  ),
                                ),
                                const VerticalDivider(),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        ));
                      },
                    );
                  } else {
                    return Center(child: Lottie.asset('assets/notfound.json'));
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
/* ((data['bal]/data[loanamount])*100 )/data[period]*/
/* find interest percent of balance and devide it by period  month */