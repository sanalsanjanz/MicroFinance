// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/view/addExternanMember.dart';
import 'package:sacco_management/president/view/giveExternalLoan.dart';
import 'package:sacco_management/president/view/viewExternalMembers.dart';

class LoanToNonMember extends StatelessWidget {
  const LoanToNonMember({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text('Loan'),
            bottom: const TabBar(
              tabs: [
                Tab(text: "Non Members"),
                Tab(text: "Give Loan"),
                Tab(text: "Add Member")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const ViewExternalMembers(),
              GiveExternalLoan(),
              AddExternalMember(),
            ],
          ),
        ),
      ),
    );
  }
}
