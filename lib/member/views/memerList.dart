// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberController.dart';

class MemberList extends StatelessWidget {
  const MemberList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: memberPrimary,
        title: const Text('Members'),
      ),
      body: Consumer<MemberHomeController>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.getMembers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text(
                          snapshot.data[0]['presname'].toString().toUpperCase(),
                        ),
                      ),
                      subtitle: const Center(child: Text('President')),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[1]['memberdata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[1]['memberdata'][index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(children: [
                                  ListTile(
                                    trailing: Text(
                                        value.memberid == data['memberid']
                                            ? 'You'
                                            : ''),
                                    title: Text(
                                      data['membername'],
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          }),
                    )
                  ],
                );
              } else {
                return const Center(
                  child: Text("No results"),
                );
              }
            },
          );
        },
      ),
    );
  }
}
