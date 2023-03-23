import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/president/view/addMember.dart';
import 'package:sacco_management/president/view/presidentConfiguration.dart';
import 'package:sacco_management/president/view/presidentExpense.dart';
import 'package:sacco_management/president/view/presidentattendance.dart';
import 'package:sacco_management/president/view/presidentloan.dart';
import 'package:sacco_management/president/view/presindentoptionalFeatures.dart';
import 'package:sacco_management/widgets/itemsCard.dart';
import '../controller/presidentConfigController.dart';
import 'loantoNonMember.dart';
import 'loantoothergroups.dart';
import 'pBankLoan.dart';
import 'presidentReports.dart';
import 'presidentSavings.dart';
import 'presidentchatpage.dart';
import 'presidentmom.dart';

class PresidentHome extends StatefulWidget {
  const PresidentHome({super.key});

  @override
  State<PresidentHome> createState() => _PresidentHomeState();
}

// late PresidentModel presidentModel;

class _PresidentHomeState extends State<PresidentHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false).getDataa();
    Provider.of<PresidentConfigController>(context, listen: false)
        .getPresidentConfig();
  }

  bool loan = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<PresidentController>(builder: (context, val, child) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: primaryColor,
                      boxShadow: const [
                        BoxShadow(spreadRadius: 2, blurRadius: 10)
                      ]),
                  // margin: const EdgeInsets.only(5),
                  height: 180, // MediaQuery.of(context).size.height * 0.20,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image(
                        width: MediaQuery.of(context).size.width / 2,
                        image: const AssetImage('assets/unitmember.png'),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              val.unitname.toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            const Divider(),
                            Items(value: val.presidentid, titile: 'UNIT ID'),
                            const SizedBox(
                              height: 5,
                            ),
                            Items(value: val.name, titile: 'NAME'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 5,
                  child: Tooltip(
                    message: 'Logout',
                    child: IconButton(
                      onPressed: () {
                        showBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            // color: primaryUnitColor,
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Do you want to Logout ?'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
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
                                        await val.logout(context);
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
                      icon: const Icon(Icons.power_settings_new,
                          color: Colors.black54),
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
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const PresidentChat(),
                        ),
                      );
                    },
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.elliptical(20, 20),
                          // bottomRight: Radius.elliptical(20, 80),
                        ),
                      ),
                      color: shadeprimaryColor,
                      child: Container(
                        // height: 150,
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.message,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    'CHATS',
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Text(
                                    val.messagecount,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const PresidentMoM(),
                        ),
                      );
                    },
                    child: Card(
                      color: shadeprimaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.elliptical(20, 20),
                          // bottomRight: Radius.elliptical(20, 80),
                        ),
                      ),
                      child: Container(
                        // height: 150,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.insights_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'MOM',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const PresidentAttendance(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10
                      // bottomRight: Radius.elliptical(20, 80),
                      ),
                ),
                // margin: const EdgeInsets.all(5),
                // padding: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.transparent,
                      child: const Image(
                        height: 55,
                        image: AssetImage('assets/edit.png'),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: shadeprimaryColor,
                          borderRadius: BorderRadius.circular(10
                              // bottomRight: Radius.elliptical(20, 80),
                              ),
                        ),
                        child: const Center(
                          child: Text(
                            'MARK ATTENDANCE',
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              height: MediaQuery.of(context).size.width / 4,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loan = !loan;
                        });
                      },
                      child: Container(
                        color: primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.description_outlined),
                            Text("Loan"),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Container(
                      color: shadeprimaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const AddMember()));
                        },
                        child: Container(
                          color: primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.group_add_rounded),
                              Text("Members"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Container(
                      color: primaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitSavings(),
                            ),
                          );
                        },
                        child: Container(
                          color: primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.monetization_on),
                              Text("Savings"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Container(
                      color: shadeprimaryColor,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const PresidentExpense(),
                            ),
                          );
                        },
                        child: Container(
                          color: primaryColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.mode_standby_outlined),
                              Text("Expense"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: loan,
              child: AnimatedContainer(
                color: shadeprimaryColor,
                duration: const Duration(seconds: 3),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PLoanToOtherGroups()));
                      },
                      child: const SizedBox(
                        width: double.maxFinite,
                        height: 45,
                        child: Card(
                          child: Center(child: Text('GROUP LOAN')),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PresidentBankLoan()));
                      },
                      child: const SizedBox(
                        width: double.maxFinite,
                        height: 45,
                        child: Card(
                          child: Center(child: Text('BANK LOAN')),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => PresidentLoan()));
                      },
                      child: const SizedBox(
                        width: double.maxFinite,
                        height: 45,
                        child: Card(
                          child: Center(child: Text('MICRO FINANCE LOAN')),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const LoanToNonMember()));
                      },
                      child: const SizedBox(
                        width: double.maxFinite,
                        height: 45,
                        child: Card(
                          child: Center(child: Text('NON-MEMBER LOAN')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const PresidentOptionalFeatures(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      color: primaryColor,
                      padding: const EdgeInsets.all(30),
                      child: const Center(
                        child: Text(
                          "Other Features",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 33, 32, 32),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (ctx) => const PresidentConfig()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(30),
                      margin: const EdgeInsets.all(5),
                      color: primaryColor,
                      child: const Center(
                          child: Text(
                        'Configuration',
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 33, 32, 32),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                )
              ],
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const PresidentReports(),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                color: primaryColor,
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/project.png'),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(Icons.mode_standby_outlined),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Reports",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 96, 92, 92),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    })
        /* Consumer<AuthController>(
        builder: (context, data, child) {
          return Column(children: [Expanded(child:
          FutureBuilder(builder:(context, snapshot) {
            if(snapshot.hasData){
              return 
            }
          }, ) )],);
        },
      ), */
        );
  }
}
