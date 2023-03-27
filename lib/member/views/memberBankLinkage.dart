// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class MemberBankLinkage extends StatefulWidget {
  const MemberBankLinkage({super.key});

  @override
  State<MemberBankLinkage> createState() => _MemberBankLinkageState();
}

class _MemberBankLinkageState extends State<MemberBankLinkage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Bank Linkage"), backgroundColor: memberPrimary),
      body: Column(
        children: [
          Expanded(child: Consumer<MemberHomeController>(
            builder: (context, value, child) {
              return FutureBuilder(
                future: value.memberBankLinkage(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data[0]['granddata'].length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[0]['granddata'][index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Items(
                                      value: data['blink_date'].toString(),
                                      titile: "Linked Date"),
                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                                  Items(
                                      value: data['amount'].toString(),
                                      titile: "Amount"),
                                  const Divider(
                                    color: Colors.transparent,
                                  ),
                                  Items(
                                      value: data['bal'].toString(),
                                      titile: "Balance"),
                                ],
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: Text("No results"),
                    );
                  }
                },
              );
            },
          ))
        ],
      ),
    );
  }
}
