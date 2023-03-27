// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberConfigController.dart';
import 'package:sacco_management/member/views/mOtherFeatures.dart';
import 'package:sacco_management/member/views/memberBankLoan.dart';
import 'package:sacco_management/member/views/memerList.dart';

import '../controllers/memberController.dart';
import 'memberReport.dart';
import 'memberloan.dart';
import 'membersearchgroup.dart';

class MemberHome extends StatefulWidget {
  const MemberHome({super.key});

  @override
  State<MemberHome> createState() => _MemberHomeState();
}

class _MemberHomeState extends State<MemberHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<MemberHomeController>(context, listen: false).getDatas();
    Provider.of<MemberConfigController>(context, listen: false)
        .getMemberConfigData();
    Provider.of<MemberHomeController>(context, listen: false)
        .getSavings(context);
  }

  bool hasdata = true;
  @override
  Widget build(BuildContext context) {
    return Consumer<MemberHomeController>(builder: (context, value, child) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[35],
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: const [BoxShadow(blurRadius: 10, spreadRadius: 0)],
                color: memberPrimary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: 220, // MediaQuery.of(context).size.height / 3,
              child: Row(
                children: [
                  Expanded(
                    // flex: 3,
                    child: Container(
                      color: Colors.green[80],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          value.membername != ''
                              ? Text(
                                  value.membername.toString().toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : const SizedBox(),
                          const Divider(height: 8),
                          value.groupname != ''
                              ? Text(
                                  value.groupname.toString().toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (c) => const SearchGroup(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Join to a unit',
                                    style: TextStyle(
                                        color: Colors.lightBlue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                          /*   const Divider(height: 8),
                          Text(
                            value.unitid == ''
                                ? ''
                                : 'UNIT ID : ${value.unitid}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ) */
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Image(
                      image: AssetImage('assets/save.png'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: containerStyle,
                              height: MediaQuery.of(context).size.height / 7,
                              //   color: Colors.pink[300],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('My Savings', style: title),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[300],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Icon(Icons.currency_rupee),
                                          Text(
                                              value.viewSavings
                                                  ? value.savings
                                                  : '*****',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  letterSpacing: 1)),
                                          IconButton(
                                            onPressed: () {
                                              value.showsavings();
                                            },
                                            icon: Icon(value.viewSavings
                                                ? Icons.visibility_off
                                                : Icons.visibility),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const VerticalDivider(width: 8),
                          Expanded(
                            child: Container(
                              decoration: containerStyle,
                              height: MediaQuery.of(context).size.height / 7,
                              // color: memberPrimary,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Monthly Collection',
                                        style: title),
                                  ),
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey[300],
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(Icons.currency_rupee),
                                          Text(value.mothlycollection)
                                          /*  IconButton(
                                            onPressed: () {},
                                            icon:
                                                const Icon(Icons.visibility),
                                          ), */
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (ctx) => const MemberList()),
                                );
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                decoration: containerStyle,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Image(
                                      height: 100,
                                      image: AssetImage('assets/users.png'),
                                    ),
                                    const Divider(),
                                    Center(
                                      child: Text(
                                        'Members'.toUpperCase(),
                                        style: title,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(width: 8),
                          Expanded(
                            child: SizedBox(
                              // padding: const EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 3.5,
                              // color: primaryColor,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => MemberLoan(
                                              unitid: value.unitid.toString(),
                                              memberid:
                                                  value.memberid.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: containerStyle,
                                        child: Center(
                                          child: Text(
                                            'Internal Loans'.toUpperCase(),
                                            style: title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) => MemberBankLoan(
                                              unitid: value.unitid.toString(),
                                              memberid:
                                                  value.memberid.toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: containerStyle,
                                        child: Center(
                                          child: Text(
                                            'Bank Loans'.toUpperCase(),
                                            style: title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(height: 10),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (ctx) =>
                                                const MOtherFetures(),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        decoration: containerStyle,
                                        child: Center(
                                          child: Text(
                                            'Others'.toUpperCase(),
                                            style: title,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const ReportsMem(),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: containerStyle,
                                height: 85,
                                // color: shadeprimaryColor,
                                child: Center(
                                  child: Text(
                                    'Reports'.toUpperCase(),
                                    style: title,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(width: 8),
                          InkWell(
                            onTap: () async {
                              return showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Do you want to Logout ?'),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('NO'),
                                          ),
                                          const VerticalDivider(),
                                          TextButton(
                                            onPressed: () async {
                                              await value.meberLogout(context);
                                            },
                                            child: const Text('YES'),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: containerStyle,
                              padding: const EdgeInsets.all(15),
                              // color: primaryColor,
                              height: 85,
                              // color: shadeprimaryColor,
                              child: const Center(
                                child: Center(
                                  child: Icon(Icons.power_settings_new),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
/*  const Color(0xff77DD77),
    const Color(0xff02d39a),
       color: const Color(0xff89DFC5), */
