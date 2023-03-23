import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controller/presidenthomecontroll.dart';

class PresidentBankLoan extends StatelessWidget {
  PresidentBankLoan({super.key});
  Widget spacer = const SizedBox(
    height: 20,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Bank Loan'),
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: val.memberlist(),
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
                                        val.setbankLoanamt(value),
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
                                        val.setbankLoanperiod(value),
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
                                        val.setbankLoaninterest(value),
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
                                        val.setbankLoanpaydate(value),
                                    decoration: const InputDecoration(
                                        hintText: '(1-31)'),
                                  ))
                                ],
                              ),
                              const Divider(),
                              CupertinoButton(
                                  child: const Text('GIVE LOAN'),
                                  onPressed: () {
                                    val.giveBankloan(
                                        id: data['memberid'], context: context);
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
