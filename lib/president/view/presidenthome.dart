import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/president/view/addMember.dart';
import 'package:sacco_management/president/view/changePresident.dart';
import 'package:sacco_management/president/view/memeberExplore.dart';
import 'package:sacco_management/president/view/presidentConfiguration.dart';
import 'package:sacco_management/president/view/presidentExpense.dart';
import 'package:sacco_management/president/view/presidentMonthlyCollection.dart';
import 'package:sacco_management/president/view/presidentSavings.dart';
import 'package:sacco_management/president/view/presidentattendance.dart';
import 'package:sacco_management/president/view/presidentloan.dart';
import 'package:sacco_management/president/view/presindentoptionalFeatures.dart';
import '../controller/presidentConfigController.dart';
import 'loantoNonMember.dart';
import 'loantoothergroups.dart';
import 'pBankLoan.dart';
import 'presidentReports.dart';
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
    Provider.of<PresidentController>(context, listen: false).getDataa(context);
    Provider.of<PresidentConfigController>(context, listen: false)
        .getPresidentConfig();
  }

  bool loan = false;
  bool savings = false;

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
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    color: primaryColor,
                  ),
                  // margin: const EdgeInsets.only(5),
                  height: 220, // MediaQuery.of(context).size.height * 0.20,
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
                            Text(
                              val.name,
                              style: title,
                            ),
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
                Positioned(
                    right: 20,
                    bottom: 5,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const ChangePresident(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: containerStyle,
                        padding: const EdgeInsets.all(8),
                        // color: Colors.white,
                        child: Center(
                          child: Row(
                            children: const [
                              Text(
                                'Change President',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              SizedBox(width: 2),
                              Icon(
                                Icons.link,
                                size: 18,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
              ],
            ),
            const Divider(
              color: Colors.transparent,
              height: 8,
            ),
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
                      color: primaryColor,
                      child: Container(
                        // height: 150,
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Stack(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.message,
                                    color: Colors.black,
                                    size: 30,
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text('CHATS', style: title),
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
                      color: primaryColor,
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
                          children: [
                            const Icon(
                              Icons.insights_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text('MOM', style: title),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PresidentAttendance(),
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: containerStylePresident,
                        child: Center(
                          child: Text('MARK ATTENDANCE', style: title),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const MemberExplore(),
                          ),
                        );
                      },
                      child: Container(
                        height: 80,
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        decoration: containerStylePresident,
                        child: Center(
                          child: Text('EXPLORE', style: title),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              padding: const EdgeInsets.all(2),
              height: MediaQuery.of(context).size.width / 4,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loan = !loan;
                          savings = false;
                        });
                      },
                      child: Container(
                        decoration: containerStylePresident,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.description_outlined),
                            const SizedBox(height: 5),
                            Text(
                              "LOAN",
                              style: title,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: Container(
                      decoration: containerStylePresident,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const AddMember()));
                        },
                        child: Container(
                          decoration: containerStylePresident,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.group_add_rounded),
                              const SizedBox(height: 5),
                              Text(
                                "MEMBER",
                                style: title,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          loan = false;
                          savings = !savings;
                        });
                      },
                      child: Container(
                        decoration: containerStylePresident,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.monetization_on),
                            const SizedBox(
                              height: 5,
                            ),
                            Text("SAVINGS", style: title),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 3),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PresidentExpense(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: containerStylePresident,
                        // color: primaryColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.mode_standby_outlined),
                            const SizedBox(height: 5),
                            Text(
                              "EXPENSE",
                              style: title,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //  Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (ctx) => UnitSavings(),
            //               ),
            //             );
            Visibility(
              visible: savings,
              child: AnimatedContainer(
                color: shadeprimaryColor,
                duration: const Duration(seconds: 3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitSavings(),
                            ),
                          );
                        },
                        child: const SizedBox(
                          width: double.maxFinite,
                          height: 45,
                          child: Card(
                            child: Center(child: Text('SAVINGS')),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => PresientMonthlyCollection(),
                            ),
                          );
                        },
                        child: const SizedBox(
                          width: double.maxFinite,
                          height: 45,
                          child: Card(
                            child: Center(child: Text('MONTHLY COLLECTION')),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: loan,
              child: AnimatedContainer(
                color: shadeprimaryColor,
                duration: const Duration(seconds: 3),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
            ),
            const SizedBox(
              height: 5,
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
                      margin: const EdgeInsets.only(left: 5),
                      decoration: containerStylePresident,
                      padding: const EdgeInsets.all(30),
                      child: const Center(
                        child: Text(
                          "OTHERS",
                          style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 249, 246, 246),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
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
                      margin: const EdgeInsets.only(right: 5),
                      decoration: containerStylePresident,
                      child: Center(
                          child: Text(
                        'Configuration'.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 5,
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
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.maxFinite,
                decoration: containerStylePresident,
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
                            "REPORTS",
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 250, 249, 249),
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
