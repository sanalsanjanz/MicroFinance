// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/view/presidentAddAccountingHead.dart';
import 'package:sacco_management/president/view/presidentProfit.dart';
import 'package:sacco_management/president/view/presidentShgPayments.dart';
import 'package:sacco_management/president/view/presidentUnitLoans.dart';
import 'package:sacco_management/president/view/presidentUpdatePassword.dart';

class PresientExplore extends StatefulWidget {
  const PresientExplore({super.key});

  @override
  State<PresientExplore> createState() => _PresientExploreState();
}

class _PresientExploreState extends State<PresientExplore> {
  bool showloan = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('More options'),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PresidentAccountingHead(),
                    ),
                  );
                },
                subtitle: const Text('handle accounting head'),
                title: const Text('Accounting Head'),
              ),
            ),
            const Card(
              child: ListTile(
                subtitle: Text('set collection'),
                title: Text('Collection'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  setState(() {
                    showloan = !showloan;
                  });
                },
                subtitle: const Text('check loan details'),
                title: const Text('Loan Details'),
              ),
            ),
            Visibility(
              visible: showloan,
              child: Container(
                margin: const EdgeInsets.all(10),
                // color: shadeprimaryColor,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PresidentSHGPayments(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('SHG LOAN'),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PresidentUnitLoans(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('UNIT LOAN'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            /*  Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PresidentExpense(),
                    ),
                  );
                },
                subtitle: const Text('add expense'),
                title: const Text('Expense'),
              ),
            ), */
            const Card(
              child: ListTile(
                subtitle: Text('pay membership fee'),
                title: Text('Pay Membership'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PresidentProfit(),
                    ),
                  );
                },
                subtitle: const Text('add profit'),
                title: const Text('Profit'),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const PresidentUpdatePassword(),
                    ),
                  );
                },
                subtitle: const Text('update your password'),
                title: const Text('Update Password'),
              ),
            ),
          ],
        ));
  }
}
