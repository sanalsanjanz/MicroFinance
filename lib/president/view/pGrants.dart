// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/president/view/pTransferGrant.dart';

import '../../widgets/itemsCard.dart';

class PGrants extends StatelessWidget {
  PGrants({super.key});
  TextEditingController amoutController = TextEditingController();
  // final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Grant'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                Consumer<PresidentController>(builder: (context, value, child) {
              return FutureBuilder(
                future: value.viewGrant(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length != 0) {
                      return Column(children: [
                        // Image(image: AssetImage(assetName))
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            padding: const EdgeInsets.all(5),
                            itemCount: snapshot.data[0]['grantdata'].length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data[0]['grantdata'][index];
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 20, bottom: 10),
                                  child: Column(
                                    children: [
                                      Items(
                                        titile: 'Grand Date',
                                        value: data['grand_date'],
                                      ),
                                      const Divider(
                                          color: Colors.transparent, height: 8),
                                      Items(
                                        titile: 'Grand Amount',
                                        value: data['amount'],
                                      ),
                                      const Divider(
                                          color: Colors.transparent, height: 8),
                                      Items(
                                        titile: 'Grand Type',
                                        value: data['type'],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (ctx) => PTransferGrant(
                                                id: data['id'],
                                                type: data['type'],
                                                amount: data['amount'],
                                                date: data['grand_date'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: const Text('Tranfer To Member'),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ]);
                    } else {
                      return const Center(
                        child: Text('Data Not Found'),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
