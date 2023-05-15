// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/views/memberBankLoanDetails.dart';
import 'package:sacco_management/member/views/memberBankLoanPayment.dart';

class MemberBankLoan extends StatelessWidget {
  MemberBankLoan({required this.unitid, required this.memberid});
  String unitid;
  String memberid;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Bank Loan'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: memberPrimary,
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
            MemberBankLoanDetails(unitid: unitid, memberid: memberid),
            MemberBankLoanPayment(unitid: unitid, memberid: memberid),
          ],
        ),
      ),
    );
  }
}
