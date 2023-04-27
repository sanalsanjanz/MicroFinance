// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitAccountingHead.dart';
import 'package:sacco_management/unit/views/unitAddShgLoan.dart';
import 'package:sacco_management/unit/views/unitBankBalancePay.dart';
import 'package:sacco_management/unit/views/unitBankLinkage.dart';
import 'package:sacco_management/unit/views/unitExpense.dart';
import 'package:sacco_management/unit/views/unitGrants.dart';
import 'package:sacco_management/unit/views/unitIncome.dart';
import 'package:sacco_management/unit/views/unitInsuranceTransfer.dart';
import 'package:sacco_management/unit/views/unitMedicalAid.dart';
import 'package:sacco_management/unit/views/unitMessages.dart';
import 'package:sacco_management/unit/views/unitRegisterNonMember.dart';
import 'package:sacco_management/unit/views/unitSavings.dart';
import 'package:sacco_management/unit/views/unitSendMessages.dart';
import 'package:sacco_management/unit/views/unitSessfund.dart';
import 'package:sacco_management/widgets/unitHomeCard.dart';

class UnitHome extends StatefulWidget {
  const UnitHome({super.key});

  @override
  State<UnitHome> createState() => _UnitHomeState();
}

class _UnitHomeState extends State<UnitHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false).getdatas();
  }

  Widget trasnsDivider = const Divider(
    height: 5,
    color: Colors.transparent,
  );
  Widget controlBuilder(
    context,
    details,
  ) {
    return Column(
      children: [
        OutlinedButton(
            onPressed: () {
              currentStep == 0
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (cv) => const UnitAddShgLoan()))
                  : '';
            },
            child: const Text('Add Loan')),
        OutlinedButton(onPressed: () {}, child: const Text('Show Borrowers')),
      ],
    );
  }

  bool viewLoan = false;
  int currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // backgroundColor: shadeUnitColor,
        child: Consumer<UnitControll>(builder: (context, value, child) {
          return Column(
            children: [
              DrawerHeader(
                curve: Curves.easeInOutCirc,
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // height: 100,
                  color: primaryUnitColor,
                  child: Column(children: [
                    //  const Divider(),
                    const CircleAvatar(
                      backgroundColor: Colors.blueGrey,
                      radius: 45,
                      child: Image(
                        image: AssetImage('assets/users.png'),
                        color: Colors.white,
                      ),
                    ),
                    const Divider(),
                    Flexible(
                      child: Center(
                        child: Text(
                          value.unitName.toString().toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Colors.white,
                              fontSize: 16),
                        ),
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                  child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                physics: const BouncingScrollPhysics(),
                children: [
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitUnitSavings(),
                          ),
                        );
                      },
                      image: 'assets/sambadyam.png',
                      title: 'SAVINGS',
                      option: true),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitSendMessages(),
                          ),
                        );
                      },
                      image: 'assets/msg.png',
                      title: 'SEND MESSAGE',
                      option: false),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitBankPayment(),
                          ),
                        );
                      },
                      image: 'assets/bank.png',
                      title: 'BANK',
                      option: true),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitTransferInsurance(),
                          ),
                        );
                      },
                      image: 'assets/insurance.png',
                      title: 'INSURANCE',
                      option: false),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitAccountingHead(),
                          ),
                        );
                      },
                      image: 'assets/accounting.png',
                      title: 'ACCOUNTING HEAD',
                      option: true),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const UnitRegisterNonMember(),
                          ),
                        );
                      },
                      image: 'assets/adduser.png',
                      title: 'NON MEMBER',
                      option: false),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () {
                        setState(() {
                          viewLoan = !viewLoan;
                        });
                      },
                      image: 'assets/loan.png',
                      title: 'UNIT LOAN',
                      option: true),
                  trasnsDivider,
                  Visibility(
                    visible: viewLoan,
                    child: Stepper(
                        controlsBuilder: controlBuilder,
                        currentStep: currentStep,
                        onStepTapped: (value) {
                          setState(() {
                            currentStep = value;
                          });
                        },
                        steps: const [
                          Step(
                            title: Text('SHG LOAN'),
                            content: Text(''),
                          ),
                          Step(
                            title: Text('INDIVIDUAL LOAN'),
                            content: Text(''),
                          ),
                          Step(
                            title: Text('NON-MEMBER LOAN'),
                            content: Text(''),
                          ),
                        ]),
                  ),
                  DrawerItem(
                      image: 'assets/reporticon.png',
                      title: 'REPORT',
                      option: false),
                  trasnsDivider,
                  DrawerItem(
                      image: 'assets/profit.png',
                      title: 'PROFIT',
                      option: true),
                  trasnsDivider,
                  DrawerItem(
                      onTap: () async {
                        await value.logout(context);
                      },
                      image: 'assets/logout.png',
                      title: 'LOGOUT',
                      option: false),
                  trasnsDivider,
                ],
              ))
            ],
          );
        }),
      ),
      appBar: AppBar(
        title: const Text('Unit'),
        actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const UnitChats(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.message,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  // alignment: Alignment.topLeft,
                  child: Consumer<UnitControll>(builder: (context, val, child) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Text(val.messageCount.toString()),
                    );
                  }))
            ],
          ),
          PopupMenuButton(
            itemBuilder: (context) =>
                [const PopupMenuItem(child: Text('Update Password'))],
          ),
        ],
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: primaryUnitColor),
        backgroundColor: primaryUnitColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                // height: 100,
                width: double.maxFinite,
                child: Row(
                  children: [
                    const CircleAvatar(
                      // backgroundColor: shadeUnitColor,
                      child: Icon(Icons.account_balance_rounded),
                    ),
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    const Text(
                      'UNIT NAME :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Consumer<UnitControll>(builder: (context, val, ch) {
                      return Text(
                        val.unitName.toString().toUpperCase(),
                        style: TextStyle(
                            color: primaryUnitColor,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitGrants(),
                                ),
                              );
                            },
                            title: 'GRANT',
                            description: 'Check your Grant activities',
                            icon: 'assets/grantshow.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitBankLinkage(),
                                ),
                              );
                            },
                            title: 'BANK LINKAGE',
                            description: 'Check your Bank activities',
                            icon: 'assets/bank.png')
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitMedicalAid(),
                                ),
                              );
                            },
                            title: 'MEDICAL AID',
                            description: 'Check your Medical Aid activities',
                            icon: 'assets/medicalaid.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitSessFund(),
                                ),
                              );
                            },
                            title: 'SESS FUND',
                            description: 'Check your Sess activities',
                            icon: 'assets/pay.png')
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitIncome(),
                                ),
                              );
                            },
                            title: 'INCOME',
                            description: 'Check your income activities',
                            icon: 'assets/income.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitExpense(),
                                ),
                              );
                            },
                            title: 'EXPENSE',
                            description: 'Check your Expense activities',
                            icon: 'assets/expenseicon.png')
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem({
    super.key,
    required this.image,
    required this.title,
    required this.option,
    this.onTap,
  });
  String title;
  String image;
  bool option;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: option ? itemlightColor : itemlightColor,
        child: ListTile(
          trailing:
              const Icon(Icons.fast_forward_outlined, color: Colors.white),
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image(
              image: AssetImage(
                image,
              ),
              color: Colors.white,
            ),
          ),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 13),
          ),
        ),
      ),
    );
  }
}
