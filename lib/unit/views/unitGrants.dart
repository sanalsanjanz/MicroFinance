// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitTransferGranttoShg.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitGrants extends StatelessWidget {
  const UnitGrants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grants'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.unitViewGrants(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['grantdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['grantdata'][index];
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Items(
                              value: data['grand_date'], titile: 'Grant  Date'),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Items(value: data['type'], titile: 'Type'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['amount'], titile: 'Amount'),
                          const Divider(),
                          SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => UnitTranferGrantToShg(
                                        gdate: data['grand_date'],
                                        gtype: data['type'],
                                        gamount: data['amount'],
                                        id: data['id']),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryUnitColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              child: const Text('DETAILS'),
                            ),
                          )
                        ],
                      ),
                    ));
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
