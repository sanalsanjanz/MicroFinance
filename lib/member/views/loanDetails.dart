// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberloanController.dart';

class LoanDetails extends StatefulWidget {
  LoanDetails({required this.unitid, required this.memberid});
  String unitid;
  String memberid;
  @override
  State<LoanDetails> createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  @override
  void initState() {
    super.initState();
    Provider.of<MemberLoanController>(context, listen: false)
        .showmemberloan(memberid: widget.memberid, unitid: widget.unitid);
  }

  Widget space = const SizedBox(
    height: 9,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MemberLoanController>(
        builder: (context, value, child) {
          return FutureBuilder(
            future: value.showmemberloan(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data[0]['message'] != 'empty') {
                  return ListView.builder(
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['loandata'][index];
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Card(
                            color: const Color.fromARGB(238, 223, 249, 241),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(data['membername']
                                      .toString()
                                      .toUpperCase()),
                                  space,
                                  Items(
                                      value: data['ldate'],
                                      titile: 'Loan Date'),
                                  space,
                                  Items(
                                      titile: 'Loan Amount',
                                      value: data['amount']),
                                  space,
                                  Items(
                                      value: data['bal'],
                                      titile: 'Loan Balance'),
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
                                      value: data['monthly_interest_amt'],
                                      titile: 'Monthly Interest'),
                                  space,
                                  Items(
                                      value: data['total_interest_amt'],
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
                  return const Center(
                    child: Text('No data found'),
                  );
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

class Items extends StatelessWidget {
  const Items({Key? key, required this.value, required this.titile})
      : super(key: key);

  final String value;
  final String titile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(titile)),
        const Center(
          child: Text(':  '),
        ),
        Expanded(child: Text(value)),
      ],
    );
  }
}
