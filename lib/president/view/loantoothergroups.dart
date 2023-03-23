// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/views/loanDetails.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

import 'unitloanReport.dart';
import 'unitloanborrowers.dart';
import 'unitloanpayment.dart';

class PLoanToOtherGroups extends StatelessWidget {
  PLoanToOtherGroups({Key? key}) : super(key: key);
  Widget spacer = const Center(child: Text(':    '));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const UnitLoanBorrowers(),
                        ),
                      );
                    },
                    child: const Text('Borrowers List')),
              ),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => UnitLoanPayment(),
                        ),
                      );
                    },
                    child: const Text('Loan Payment')),
              ),
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const UnitLoanReport(),
                        ),
                      );
                    },
                    child: const Text('Loan Report')),
              ),
            ],
          ),
        ],
        title: const Text('Loan to Groups'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: val.groupList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) => const Divider(),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data[0]['shgdata'].length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data[0]['shgdata'][index];
                      return Column(
                        children: [
                          Items(
                            value: snapshot.data[1]['sambhadyam'],
                            titile: 'Savings',
                          ),
                          Card(
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                      data['shgname'].toString().toUpperCase()),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Loan Amount')),
                                      spacer,
                                      Expanded(
                                          child: TextField(
                                        onChanged: (value) =>
                                            val.setshgloanamt(value),
                                        decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons
                                                .currency_exchange_outlined)),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                          child: Text('Loan Period')),
                                      spacer,
                                      Expanded(
                                          child: TextField(
                                        onChanged: (value) =>
                                            val.setshgloanperiod(value),
                                        decoration: const InputDecoration(
                                            suffix: Text('/months')),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(child: Text('Interest')),
                                      spacer,
                                      Expanded(
                                          child: TextField(
                                        onChanged: (value) =>
                                            val.setshgloaninterest(value),
                                        decoration: const InputDecoration(
                                            suffixIcon: Icon(Icons.percent)),
                                      ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text('Payment Date'),
                                      ),
                                      spacer,
                                      Expanded(
                                          child: TextField(
                                        onChanged: (value) =>
                                            val.setshgloanpaydate(value),
                                        decoration: const InputDecoration(
                                            hintText: '(1-31)'),
                                      ))
                                    ],
                                  ),
                                  const Divider(),
                                  CupertinoButton(
                                      child: const Text('GIVE LOAN'),
                                      onPressed: () async {
                                        await val.giveshgloan(data['shgid'],
                                            data['shgname'], context);
                                      })
                                ],
                              ),
                            ),
                          ),
                        ],
                      );

                      /* ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                        ),
                      ),
                      title: Text(data['membername']),
                      subtitle: Text(data['memberid']),
                    ); */
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: shadeprimaryColor,
                    ),
                  );
                }
              },
            ))
          ],
        );
      }),
    );
  }
}
