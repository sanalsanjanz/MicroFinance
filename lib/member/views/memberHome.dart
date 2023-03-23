// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberConfigController.dart';
import 'package:sacco_management/member/views/mOtherFeatures.dart';

import '../controllers/memberController.dart';
import 'memberReport.dart';
import 'memberloan.dart';
import 'membersearchgroup.dart';
import 'myshares.dart';

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
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              height: 150, // MediaQuery.of(context).size.height / 3,
              child: Row(
                children: [
                  Expanded(
                    // flex: 3,
                    child: Container(
                      color: Colors.green[80],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          value.groupname != ''
                              ? Text(
                                  value.groupname.toString().toUpperCase(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
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
                          const Divider(),
                          Text(
                            value.unitid == ''
                                ? ''
                                : 'UNIT ID : ${value.unitid}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
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
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                              //   color: Colors.pink[300],
                              child: Card(
                                color: shadeprimaryColor,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'My Savings',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                          ),
                          const VerticalDivider(),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 7,
                              //   color: Colors.pink[300],
                              child: Card(
                                color: shadeprimaryColor,
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Monthly Collection',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
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
                          ),
                        ],
                      ),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => const MyShares(),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                padding: const EdgeInsets.all(8),
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                color: primaryColor,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      height: 70,
                                      image: AssetImage('assets/income.png'),
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                    ),
                                    Divider(),
                                    Text('Manage'),
                                    Text('Shares')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const VerticalDivider(),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: MediaQuery.of(context).size.height / 3.5,
                              // color: primaryColor,
                              child: Column(
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
                                        color: primaryColor,
                                        child: const Center(
                                          child: Text('Loans'),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Expanded(
                                    child: Container(
                                      color: primaryColor,
                                      child: const Center(
                                          child: Text('Check fines')),
                                    ),
                                  ),
                                  const Divider(),
                                  Expanded(
                                    child: Container(
                                      color: primaryColor,
                                      child: const Center(
                                        child: Text('Collections'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const MOtherFetures(),
                            ),
                          );
                        },
                        child: Card(
                          //elevation: 5,
                          color: shadeprimaryColor,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 85,
                            // color: shadeprimaryColor,
                            child: const Center(
                              child: Text('Other Features'),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => MemberReport(
                                presid: value.unitid.toString(),
                              ),
                            ),
                          );
                        },
                        child: Card(
                          //elevation: 5,
                          color: shadeprimaryColor,
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            height: 85,
                            // color: shadeprimaryColor,
                            child: const Center(
                              child: Text('Reports'),
                            ),
                          ),
                        ),
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