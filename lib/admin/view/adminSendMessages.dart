// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sacco_management/admin/view/adminRegionalChat.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/view/regionalAddBankLinkage.dart';
import 'package:sacco_management/regional/view/regionalPayBankLinkage.dart';

import 'adminShgChat.dart';
import 'adminUnitChat.dart';

class AdminSendMessages extends StatelessWidget {
  const AdminSendMessages();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Chats'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryAdminColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("Regional"),
              ),
              Tab(
                child: Text("Unit"),
              ),
              Tab(
                child: Text("SHG"),
              ),
            ])),
        body: const TabBarView(
          physics: BouncingScrollPhysics(),
          children: [
            AdminRegionalChat(),
            AdminUnitChat(),
            AdminSHGChat(),
          ],
        ),
      ),
    );
  }
}
