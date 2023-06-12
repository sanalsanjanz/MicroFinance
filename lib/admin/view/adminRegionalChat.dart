import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

import 'adminIndividualMessage.dart';

class AdminRegionalChat extends StatelessWidget {
  const AdminRegionalChat({super.key});

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
                      type: 'REGALL',
                    ),
                  ),
                );
              },
              title: const Center(
                child: Text('Send To All Regionals'),
              ),
            ),
          ),
          Expanded(
            child: Consumer<AdminController>(builder: (context, value, child) {
              return FutureBuilder(
                  future: value.getAllRegionalList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[0]['regiondata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['regiondata'][index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => AdminIndividualMessage(
                                        type: 'REGIND',
                                        passbookNo: data['passbook_no'],
                                        name: data['region'],
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Text((index + 1).toString()),
                                ),
                                title: Text(data['region']),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('No regional found'),
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
