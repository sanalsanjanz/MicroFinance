// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitShgLoanBorrowDetails.dart';

class UnitShgLoanBorrowers extends StatelessWidget {
  const UnitShgLoanBorrowers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose SHG'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getUnitBorrowersList(context: context, type: 'SHG'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data[0]['shgdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['shgdata'][index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitShgLoanBorrowDetails(
                                passbookno: data['shg_passbook_no'],
                              ),
                            ),
                          );
                        },
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Tap to select'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['shg_name']),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Lottie.asset('assets/notfound.json'));
              }
            } else {
              return Center(
                child: SpinKitFadingCircle(color: primaryColor),
              );
            }
          },
        );
      }),
    );
  }
}
