// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class ViewExternalMembers extends StatelessWidget {
  const ViewExternalMembers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PresidentController>(builder: (context, value, child) {
        return FutureBuilder(
          future: value.getExternalMembers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  // padding: const EdgeInsets.all(10),
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: snapshot.data[0]['memberdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['memberdata'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: shadeprimaryColor,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(data['membername']),
                    );
                  });
            } else {
              return const Center(child: Text('No Members'));
            }
          },
        );
      }),
    );
  }
}
