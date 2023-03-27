// ignore_for_file: file_names, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberloanController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class MemberBankLoanDetails extends StatefulWidget {
  MemberBankLoanDetails({required this.unitid, required this.memberid});
  String unitid;
  String memberid;
  @override
  State<MemberBankLoanDetails> createState() => _MemberBankLoanDetailsState();
}

class _MemberBankLoanDetailsState extends State<MemberBankLoanDetails> {
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
            future: value.showMemberBankLoanBorrows(
                unitid: widget.unitid, memberid: widget.memberid),
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
                                  const Divider(),
                                  Items(value: data['loanid'], titile: 'Id'),
                                  space,
                                  Items(
                                      titile: 'Loan Amount',
                                      value: data['loan_amt']),
                                  space,
                                  Items(
                                      value: data['paid_loan_amt'],
                                      titile: 'Paid'),
                                  space,
                                  Items(
                                      value: data['interest_amt'],
                                      titile: 'Loan Interest'),
                                  space,
                                  Items(
                                      value: data['pay_date'], titile: 'Date'),
                                  space,
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
                    child: Text('No loan found'),
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
