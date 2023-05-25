import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/view/regionalAddProject.dart';
import 'package:sacco_management/regional/view/regionalViewProjects.dart';

class RegionalProject extends StatelessWidget {
  const RegionalProject({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('Projects'),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: primaryRegionColor,
            bottom: const TabBar(indicatorColor: Colors.white, tabs: [
              Tab(
                child: Text("View"),
              ),
              Tab(
                child: Text("Add"),
              )
            ])),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: [
            const RegionalViewProject(),
            RegionalAddProject(),
          ],
        ),
      ),
    );
  }
}
