// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitBankLinkageFromRegion extends StatefulWidget {
  UnitBankLinkageFromRegion({super.key, required this.shgpass});
  String shgpass;

  @override
  State<UnitBankLinkageFromRegion> createState() =>
      _UnitBankLinkageFromRegionState();
}

class _UnitBankLinkageFromRegionState extends State<UnitBankLinkageFromRegion> {
  String paydate = '';

  dates() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatedDate = formatter.format(DateTime.now());
    setState(() {
      paydate = formatedDate;
    });
  }

  @override
  void initState() {
    super.initState();
    dates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Details'),
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.viewUnitBankLinkageFromRegion(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length != 0) {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data[0]['blink'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['blink'][index];
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Items(value: paydate, titile: 'Payment Date'),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Items(
                              value: data['ldate'],
                              titile: 'Bank linkage date'),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Items(
                              value: data['amount'],
                              titile: 'Bank linkage amount'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['bal'], titile: 'Balance amount'),
                          const Divider(color: Colors.transparent),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: shadeUnitColor,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () async {
                              await val.payBankLinkageRegion(
                                  context: context,
                                  loanid: data['id'],
                                  paydate: paydate);
                            },
                            child: const Text('Pay'),
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
                child: CircularProgressIndicator(color: primaryUnitColor),
              );
            }
          },
        );
      }),
    );
  }
}
