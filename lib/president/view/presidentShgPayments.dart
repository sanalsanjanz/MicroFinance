// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/view/presidentShgLoanData.dart';
import 'package:sacco_management/president/view/presidentshgLoanPaymentInfo.dart';

class PresidentSHGPayments extends StatelessWidget {
  const PresidentSHGPayments();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('SHG Loan'),
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
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [PresidentShgLoanData(), PresidentSHGPayment()],
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
