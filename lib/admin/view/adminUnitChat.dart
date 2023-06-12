import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/admin/view/adminIndividualMessage.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminUnitChat extends StatelessWidget {
  const AdminUnitChat({super.key});

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
                    builder: (ctx) => AdminIndividualMessage(
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
            child: Consumer<AdminController>(builder: (context, value, child) {
              return FutureBuilder(
                  future: value.getAllUnits(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[0]['unitdata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['unitdata'][index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => AdminIndividualMessage(
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
