import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/admin/view/adminIndividualMessage.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminSHGChat extends StatelessWidget {
  const AdminSHGChat({super.key});

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
                      type: 'SHGALL',
                    ),
                  ),
                );
              },
              title: const Center(
                child: Text('Send To All SHG'),
              ),
            ),
          ),
          Expanded(
            child: Consumer<AdminController>(builder: (context, value, child) {
              return FutureBuilder(
                  future: value.getAllShg(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[0]['shgdata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['shgdata'][index];
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => AdminIndividualMessage(
                                        type: 'SHGIND',
                                        passbookNo: data['passbook_no'],
                                        name: data['unit_name'],
                                      ),
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: primaryColor,
                                  child: Text((index + 1).toString()),
                                ),
                                title: Text(data['unit_name']),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: Text('No Shg found'),
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
