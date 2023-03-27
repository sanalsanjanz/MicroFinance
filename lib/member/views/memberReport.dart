import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/views/memberAttendance.dart';
import 'package:sacco_management/member/views/memberExpense.dart';
import 'package:sacco_management/member/views/memberMonthlyCollection.dart';
import 'package:sacco_management/member/views/memberOveralreport.dart';

class ReportsMem extends StatelessWidget {
  const ReportsMem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: memberPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => MemberOveralReport(
                                    presid: '',
                                  )),
                        );
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(child: Text('Overal Report')),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (ctx) => MemberMonthlyCollection(
                                    presid: '',
                                  )),
                        );
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(child: Text('Monthly Collection')),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const MemberAttendance(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(child: Text('Attendance')),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const MemberExpense(),
                          ),
                        );
                      },
                      child: Container(
                        height: 60,
                        padding: const EdgeInsets.all(8.0),
                        child: const Center(child: Text('Expense')),
                      ),
                    ),
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
