// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/view/regionalShgChat.dart';
import 'package:sacco_management/regional/view/regionalUnitChat.dart';

class RegionalSendMessage extends StatelessWidget {
  const RegionalSendMessage();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Chats'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryRegionColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("Group"),
              ),
              Tab(
                child: Text("Units"),
              ),
            ])),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            RegionalShgChat(),
            RegionalUnitChat(),
          ],
        ),
      ),
    );
  }
}
