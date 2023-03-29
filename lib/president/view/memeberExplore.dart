import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/view/memberAddAccountingHead.dart';

class MemberExplore extends StatelessWidget {
  const MemberExplore({super.key});

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
                      builder: (ctx) => const MemberAddAccountingHead(),
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
            const Card(
              child: ListTile(
                subtitle: Text('check loan details'),
                title: Text('Loan Details'),
              ),
            ),
            const Card(
              child: ListTile(
                subtitle: Text('add expense'),
                title: Text('Expense'),
              ),
            ),
            const Card(
              child: ListTile(
                subtitle: Text('pay membership fee'),
                title: Text('Pay Membership'),
              ),
            ),
            const Card(
              child: ListTile(
                subtitle: Text('add profit'),
                title: Text('Profit'),
              ),
            ),
            const Card(
              child: ListTile(
                subtitle: Text('update your password'),
                title: Text('Update Password'),
              ),
            ),
          ],
        ));
  }
}
