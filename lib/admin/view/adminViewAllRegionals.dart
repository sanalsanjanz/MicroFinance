import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminViewRegionalList extends StatelessWidget {
  const AdminViewRegionalList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Regional'),
        backgroundColor: primaryAdminColor,
      ),
      body: Column(
        children: [
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
