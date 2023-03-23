// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class GiveExternalLoan extends StatelessWidget {
  GiveExternalLoan({super.key});
  Widget spacer = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: val.getExternalMembers(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, index) => const Divider(),
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data[0]['memberdata'].length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data[0]['memberdata'][index];
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Text(data['membername'].toString().toUpperCase()),
                              const Divider(),
                              Row(
                                children: [
                                  const Expanded(child: Text('Loan Amount')),
                                  spacer,
                                  Expanded(
                                      child: TextField(
                                    onChanged: (value) =>
                                        val.setexternalLoanamt(value),
                                    decoration: const InputDecoration(
                                        suffixIcon: Icon(
                                            Icons.currency_exchange_outlined)),
                                  ))
                                ],
                              ),
                              Row(
                                children: [
                                  const Expanded(child: Text('Loan Period')),
                                  spacer,
                                  Expanded(
                                      child: TextField(
                                    onChanged: (value) =>
                                        val.setexternalLoanperiod(value),
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
                                        val.setexternalLoaninterest(value),
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
                                        val.setexternalLoanpaydate(value),
                                    decoration: const InputDecoration(
                                        hintText: '(1-31)'),
                                  ))
                                ],
                              ),
                              const Divider(),
                              CupertinoButton(
                                  child: const Text('GIVE LOAN'),
                                  onPressed: () async {
                                    await val.giveExternalLoan(
                                        data['memberid'], context);
                                  })
                            ],
                          ),
                        ),
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
