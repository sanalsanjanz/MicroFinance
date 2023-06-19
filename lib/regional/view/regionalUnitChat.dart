import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionalSendIndividualMessages.dart';

class RegionalUnitChat extends StatelessWidget {
  const RegionalUnitChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => RegionalSendIndMessages(
                      type: 'UNITALL',
                    ),
                  ),
                );
              },
              title: const Center(
                child: Text('Send To All Units'),
              ),
            ),
          ),
          Expanded(
            child:
                Consumer<RegionalController>(builder: (context, value, child) {
              return FutureBuilder(
                  future: value.regionalGetUnits(option: 2),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[0]['bnkdata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['bnkdata'][index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => RegionalSendIndMessages(
                                        type: 'UNITIND',
                                        passbookNo: data['passbook_no'],
                                        name: data['unit'],
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Text((index + 1).toString()),
                                ),
                                title: Text(data['unit']),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('No Units found'),
                      );
                    }
                  });
            }),
          )
        ],
      ),
    );
  }
}
