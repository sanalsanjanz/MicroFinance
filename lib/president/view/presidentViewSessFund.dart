// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

import '../controller/presidenthomecontroll.dart';

class PresidentViewSessFund extends StatelessWidget {
  PresidentViewSessFund({super.key});
  Widget space = const SizedBox(
    height: 9,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Sess'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PresidentController>(builder: (context, value, ch) {
        return FutureBuilder(
          future: value.presidentViewSess(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0]['message'] == 'no datas') {
                return const Center(
                  child: Text('Empty'),
                );
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['sessdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sessdata'][index];
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Card(
                        color: const Color.fromARGB(204, 220, 231, 228),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space,
                              Items(value: data['c_sessid'], titile: 'Sess Id'),
                              space,
                              Items(
                                  value: data['sessfund_date'],
                                  titile: 'Sess Date'),
                              space,
                              Items(
                                  titile: 'Sess Amount', value: data['amount']),
                              space,
                              Items(value: data['period'], titile: 'Period'),
                              space,
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
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
