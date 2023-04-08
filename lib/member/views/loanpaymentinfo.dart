import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberloanController.dart';

class LoanPaymentInfo extends StatelessWidget {
  const LoanPaymentInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Consumer<MemberLoanController>(
                      builder: (context, value, child) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.setinterestclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color:
                              value.intresest ? Colors.blueGrey : primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(13),
                        duration: const Duration(seconds: 1),
                        child: const Center(
                          child: Text(
                            'Interest Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Consumer<MemberLoanController>(
                      builder: (context, value, ch) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.setamountclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: value.amount ? Colors.blueGrey : primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(13),
                        duration: const Duration(seconds: 1),
                        child: const Center(
                          child: Text(
                            'Amount Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(child:
                Consumer<MemberLoanController>(builder: (context, value, ch) {
              return value.intresest
                  ? FutureBuilder(
                      future: value.showInterest(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data[0]['message'] == 'empty') {
                            return const Center(
                              child: Text('Empty'),
                            );
                          } else {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data[0]['loandata'].length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data[0]['loandata'][index];
                                return Card(
                                  child: ListTile(
                                    title: Text(data['membername']),
                                    subtitle: Text(data['pay_date']),
                                    trailing: SizedBox(
                                        width: 100,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.currency_rupee),
                                            Text(data['paid_int_amt'] ??
                                                'loading')
                                          ],
                                        )),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : FutureBuilder(
                      future: value.showamountpayment(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data[0]['message'] == 'empty') {
                            return const Center(
                              child: Text('No payment history'),
                            );
                          } else {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: snapshot.data[0]['loandata'].length,
                              itemBuilder: (context, index) {
                                var data = snapshot.data[0]['loandata'][index];
                                return Card(
                                  child: ListTile(
                                    title: Text(data['membername']),
                                    subtitle: Text(data['pay_date']),
                                    trailing: Column(
                                      children: [
                                        SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const Icon(
                                                    Icons.currency_rupee),
                                                Text(data['paid'] ?? 'loading'),
                                              ],
                                            )),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        SizedBox(
                                            width: 100,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text("(${data['loan_amt']})"),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    );
            }))
          ],
        ),
      ),
    );
  }
}
