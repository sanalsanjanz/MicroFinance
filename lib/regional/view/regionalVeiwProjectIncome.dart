// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controller/regionalController.dart';

class RegionalVeiwProjectIncome extends StatelessWidget {
  RegionalVeiwProjectIncome({super.key, required this.projectid});
  String projectid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Income'),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(
        builder: (context, myType, child) {
          return FutureBuilder(
            future: myType.searchProject(projectid: projectid),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data[2]['incomedata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[2]['incomedata'][index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          data['c_date'],
                        ),
                        subtitle: Text(data['type']),
                        trailing: Text(data['amount']),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryRegionColor,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
