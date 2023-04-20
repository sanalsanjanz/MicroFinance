// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

import '../controller/presidenthomecontroll.dart';

class PresidentPaySessFund extends StatelessWidget {
  PresidentPaySessFund({super.key});
  Widget space = const SizedBox(
    height: 9,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Sess'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PresidentController>(builder: (context, value, ch) {
        return FutureBuilder(
          future: value.presidentSessfundPayment(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data[0]['message'] == 'no datas') {
                return const Center(
                  child: Text('Empty'),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, top: 20, bottom: 2),
                          child: Column(
                            children: [
                              Items(
                                  value: value.paysessAmount,
                                  titile: 'Sess Amount'),
                              const Divider(),
                              /*    OutlinedButton(
                                onPressed: () {},
                                child: const Text('Transfer'),
                              ), */
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data[0]['sessdata'].length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['sessdata'][index];
                            return Card(
                              color: const Color.fromARGB(204, 220, 231, 228),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        data['member_name'],
                                      ),
                                    ),
                                    space,
                                    Items(
                                        value: data['amount'],
                                        titile: 'Sess Amount'),
                                    space,
                                    Items(
                                        value: data['balance_amt'],
                                        titile: 'Balance'),
                                    space,
                                    Items(
                                        value: data['paid'].toString(),
                                        titile: 'Paid Amount'),
                                    space,
                                    Items(
                                        value: data['sessfund_date'],
                                        titile: 'Sess Date'),
                                    space,
                                    const Divider(),
                                    Center(
                                      child: OutlinedButton(
                                          onPressed: () async {
                                            await value.transferSesstoMember(
                                                sessid: data['c_sessid'],
                                                membpassbook:
                                                    data['member_passbook_no'],
                                                amounts: data['amount'],
                                                sessdate: data['sessfund_date'],
                                                periods: '0',
                                                shgpassbook:
                                                    data['shg_passbook_no'],
                                                context: context);
                                          },
                                          child: const Text('PAY SESS FUND')),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
