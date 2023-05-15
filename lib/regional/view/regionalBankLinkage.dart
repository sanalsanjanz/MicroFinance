// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/view/regionalAddBankLinkage.dart';
import 'package:sacco_management/regional/view/regionalPayBankLinkage.dart';

class RegionalBankLinkage extends StatelessWidget {
  const RegionalBankLinkage();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Bank Linkage'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryRegionColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("Pay"),
              ),
              Tab(
                child: Text("Add"),
              )
            ])),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            RegionalPayBankLinkage(),
            RegionalAddBankLinkage(),
          ],
        ),
      ),
    );
  }
}
