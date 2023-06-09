// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitMedicalAidTranferRegion extends StatelessWidget {
  UnitMedicalAidTranferRegion({super.key, required this.shgpass});
  String shgpass;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Details'),
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.unitshgmedicalAidTransfer(
              context: context, shgPassbookno: shgpass),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data[0]['sdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sdata'][index];
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Items(value: data['shgname'], titile: 'SHG NAME'),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Items(value: data['amount'], titile: 'SESS AMOUNT'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['pdate'], titile: 'PAY DATE'),
                          const Divider(color: Colors.transparent),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: shadeUnitColor,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () async {
                              await val.unitTransferMedicalAid(
                                  context: context, mid: data['mid']);
                            },
                            child: const Text('Transfer to Region'),
                          ),
                        ],
                      ),
                    )

                        /* ListTile(
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Tap to select'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['shgname']),
                      ), */
                        );
                  },
                );
              } else {
                return Center(child: Lottie.asset('assets/notfound.json'));
              }
            } else {
              return Center(
                  child: SpinKitFadingCircle(color: primaryUnitColor));
            }
          },
        );
      }),
    );
  }
}
