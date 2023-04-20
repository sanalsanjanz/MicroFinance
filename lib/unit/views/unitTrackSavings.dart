// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitTrackSavings extends StatelessWidget {
  UnitTrackSavings({super.key, required this.passno});
  String passno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Track Details'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.unitTrackshgsambadhyam(
              context: context, shgpassbookno: passno),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                  padding: const EdgeInsets.all(5),
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['sdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sdata'][index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          /* Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitGiveBankLinkageMember(),
                            ),
                          ); */
                        },
                        trailing: Text(data['amount']),
                        subtitle: Text(data['pdate']),
                        leading: CircleAvatar(
                          backgroundColor: shadeUnitColor,
                          child: const Icon(
                            Icons.polymer_sharp,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['shgname']),
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
