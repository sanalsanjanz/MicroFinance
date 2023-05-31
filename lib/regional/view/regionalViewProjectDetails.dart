// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionalVeiwProjectExpense.dart';
import 'package:sacco_management/regional/view/regionalVeiwProjectIncome.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalViewProjectDetails extends StatelessWidget {
  RegionalViewProjectDetails(
      {super.key,
      required this.agency,
      required this.area,
      required this.duration,
      required this.estimate,
      required this.projectName,
      required this.projectId,
      required this.date,
      required this.purpose});
  String projectName;
  String projectId;
  String agency;
  String estimate;
  String date;
  String area;
  String purpose;
  String duration;
  TextEditingController addExAmount = TextEditingController();
  TextEditingController addExType = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        backgroundColor: primaryRegionColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Items(value: projectName, titile: 'Project Name'),
                    const Divider(),
                    Items(value: agency, titile: 'Funding Agency'),
                    const Divider(),
                    Items(value: estimate, titile: 'Estimate'),
                    const Divider(),
                    Items(value: area, titile: 'Area'),
                    const Divider(),
                    Items(value: purpose, titile: 'Purpose'),
                    const Divider(),
                    Items(value: duration, titile: 'Duration'),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRegionColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctc) =>
                              RegionalVeiwProjectExpense(projectid: projectId),
                        ),
                      );
                    },
                    child: const Text('View Expense'),
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRegionColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctc) =>
                              RegionalVeiwProjectIncome(projectid: projectId),
                        ),
                      );
                    },
                    child: const Text('View Income'),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRegionColor),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(
                            child: Text('Add Expense'),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                readOnly: true,
                                decoration: InputDecoration(hintText: date),
                              ),
                              TextField(
                                controller: addExAmount,
                                decoration: const InputDecoration(
                                    hintText: 'Expense amount'),
                              ),
                              TextField(
                                controller: addExType,
                                decoration: const InputDecoration(
                                    hintText: 'Expense type'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            Consumer<RegionalController>(
                                builder: (context, val, child) {
                              return TextButton(
                                onPressed: () async {
                                  await val.submitExpense(
                                      context: context,
                                      amount: addExAmount.text,
                                      date: date,
                                      type: addExType.text,
                                      projectid: projectId);
                                },
                                child: const Text('Add'),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                    child: const Text('Add Expense'),
                  ),
                ),
                const VerticalDivider(),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRegionColor),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Center(
                            child: Text('Add Income'),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                readOnly: true,
                                decoration: InputDecoration(hintText: date),
                              ),
                              TextField(
                                controller: addExAmount,
                                decoration: const InputDecoration(
                                    hintText: 'Income amount'),
                              ),
                              TextField(
                                controller: addExType,
                                decoration: const InputDecoration(
                                    hintText: 'Income type'),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Cancel'),
                            ),
                            Consumer<RegionalController>(
                                builder: (context, val, child) {
                              return TextButton(
                                onPressed: () async {
                                  await val.submitIncome(
                                      context: context,
                                      amount: addExAmount.text,
                                      date: date,
                                      type: addExType.text,
                                      projectid: projectId);
                                },
                                child: const Text('Add'),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                    child: const Text('Add Income'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
