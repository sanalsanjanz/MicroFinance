import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/view/regionalPaySessFund.dart';
import 'package:sacco_management/regional/view/regionalSessTransferToCenter.dart';
import 'package:sacco_management/regional/view/regionalViewSessFund.dart';

class RegionalSessFund extends StatelessWidget {
  const RegionalSessFund({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('SESS FUND'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryRegionColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("View"),
              ),
              Tab(
                child: Text("Pay"),
              ),
              Tab(
                child: Text("Transfer"),
              ),
            ])),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            const RegionalViewSessFund(),
            const RegionalPaySessFund(),
            RegionalSessTransferToCenter(),
          ],
        ),
      ),
    ); /*  */
  }
}
