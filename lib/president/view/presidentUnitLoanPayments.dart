// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class PresidentUnitLoanPayment extends StatelessWidget {
  PresidentUnitLoanPayment({super.key});

  Widget space = const SizedBox(
    height: 9,
  );
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
                  child: Consumer<PresidentController>(
                      builder: (context, value, child) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.issetinterestclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color:
                              value.intresest ? primaryColor : Colors.blueGrey,
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
                  child: Consumer<PresidentController>(
                      builder: (context, value, ch) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.issetamountclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: value.amount ? primaryColor : Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(13),
                        duration: const Duration(milliseconds: 100),
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
                Consumer<PresidentController>(builder: (context, value, ch) {
              return value.isintresest
                  ? FutureBuilder(
                      future: value.presidentunitLoanInterestPaymentData(),
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
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        204, 220, 231, 228),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          space,
                                          Items(
                                              value: data['membername'],
                                              titile: 'Member Name'),
                                          space,
                                          Items(
                                              value: data['ldate'],
                                              titile: 'Loan Date'),
                                          space,
                                          Items(
                                              titile: 'Loan Amount',
                                              value: data['amount']),
                                          space,
                                          Items(
                                              value: data['bal'],
                                              titile: 'Balance'),
                                          space,
                                          Items(
                                              value: data['monthlyinterest'],
                                              titile: 'Monthly Interest'),
                                          space,
                                          Items(
                                              value: data['paydate'],
                                              titile: 'Pay Date')
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return Center(
                            child: SpinKitFadingCircle(color: primaryColor),
                          );
                        }
                      },
                    )
                  : FutureBuilder(
                      future: value.presidentunitLoanPayment(),
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
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        204, 220, 231, 228),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Items(
                                              value: data['passbookno'],
                                              titile: 'Passbook Number'),
                                          space,
                                          Items(
                                              value: data['unitname'],
                                              titile: 'Unit Name'),
                                          space,
                                          Items(
                                              value: data['shgname'],
                                              titile: 'Group Name'),
                                          space,
                                          Items(
                                              value: data['paydate'],
                                              titile: 'Loan pay Date'),
                                          space,
                                          Items(
                                              titile: 'Loan Amount',
                                              value: data['loanamount']),
                                          space,
                                          Items(
                                              value: data['paid_loan_amt'],
                                              titile: 'Last Paid'),
                                          space,
                                          Items(
                                              value: data['paid'],
                                              titile: 'Paid Amount'),
                                          space,
                                          Items(
                                              value: data['interest_amt'],
                                              titile: 'Interest Amount')
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        } else {
                          return Center(
                              child: SpinKitFadingCircle(color: primaryColor));
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
