// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';

import 'loanDetails.dart';
import 'loanpaymentinfo.dart';

class MemberLoan extends StatelessWidget {
  MemberLoan({required this.unitid, required this.memberid});
  String unitid;
  String memberid;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('LOANS'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("Loan Details"),
              ),
              Tab(
                child: Text("Payment Info"),
              )
            ])),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            LoanDetails(unitid: unitid, memberid: memberid),
            const LoanPaymentInfo(),
          ],
        ),
      ),
    );

    /*   Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.contacts), text: "Tab 1"),
              Tab(icon: Icon(Icons.camera_alt), text: "Tab 2")
            ],
          ),
          automaticallyImplyLeading: false,
          title: const Text('Loans'),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: ); */
  }
}
