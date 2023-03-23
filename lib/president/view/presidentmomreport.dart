import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class PresidentMomReport extends StatelessWidget {
  const PresidentMomReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: val.getmomreport(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      padding: const EdgeInsets.all(5),
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data['0'][0].length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data['0'][0][index];
                        return Card(
                            child: Column(
                          children: [
                            Container(
                              height: 40,
                              width: double.maxFinite,
                              color: shadeprimaryColor,
                              child: const Center(child: Text('MOM RECORD')),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 10, bottom: 10),
                              child: Column(
                                children: [
                                  Items(value: data['date'], titile: "Date"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['location'],
                                      titile: "Location"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['attendance'],
                                      titile: "Attendance"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['decision'],
                                      titile: "Decision"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Items(
                                      value: data['summery'],
                                      titile: "Summery"),
                                ],
                              ),
                            ),
                          ],
                        ));
                      },
                    );
                  } else {
                    return const Center(
                      child: Text('no data found'),
                    );
                  }
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
