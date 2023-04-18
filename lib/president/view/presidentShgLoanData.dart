// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

import 'package:sacco_management/widgets/itemsCard.dart';

class PresidentShgLoanData extends StatefulWidget {
  const PresidentShgLoanData(
      /* {required this.unitid, required this.memberid} */);
  // String unitid;
  // String memberid;
  @override
  State<PresidentShgLoanData> createState() => _PresidentShgLoanDataState();
}

class _PresidentShgLoanDataState extends State<PresidentShgLoanData> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false)
        .getPresidentShgloanPaymentDet();
  }

  Widget space = const SizedBox(
    height: 9,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PresidentController>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.getSHGLoanDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data[0]['message'] != 'no datas') {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['loandata'][index];
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
                                  Text(
                                    data['membername'].toString().toUpperCase(),
                                    style: title,
                                  ),
                                  space,
                                  Items(
                                      value: data['unitname'],
                                      titile: 'Unit Name'),
                                  space,
                                  Items(
                                      value: data['ldate'],
                                      titile: 'Loan Date'),
                                  space,
                                  Items(
                                      titile: 'Loan Amount',
                                      value: data['amount']),
                                  space,
                                  Items(value: data['bal'], titile: 'Balance'),
                                  space,
                                  Items(
                                      value: data['interest'] + '%',
                                      titile: 'Loan Interest'),
                                  space,
                                  Items(
                                      value: data['period'] + '/months',
                                      titile: 'Loan Period'),
                                  space,
                                  Items(
                                      value: data['installment'],
                                      titile: 'Loan Installment'),
                                  space,
                                  Items(
                                      value: data['monthlyinterest'],
                                      titile: 'Monthly Interest'),
                                  space,
                                  Items(
                                      value: data['totalinterest'],
                                      titile: 'Toatal Interest')
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      //   separatorBuilder: (context, index) => const Divider(),
                      itemCount: snapshot.data[0]['loandata'].length);
                } else {
                  return Center(child: Lottie.asset('assets/notfound.json'));
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: shadeprimaryColor,
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
