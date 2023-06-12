import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/admin/view/adminAddBankLinkage.dart';
import 'package:sacco_management/admin/view/adminAddGrant.dart';
import 'package:sacco_management/admin/view/adminAddIncome.dart';
import 'package:sacco_management/admin/view/adminAddRegional.dart';
import 'package:sacco_management/admin/view/adminAddUnit.dart';
import 'package:sacco_management/admin/view/adminMedicalAid.dart';
import 'package:sacco_management/admin/view/adminSendMessages.dart';
import 'package:sacco_management/admin/view/adminSessFund.dart';
import 'package:sacco_management/admin/view/adminViewAllRegionals.dart';
import 'package:sacco_management/constants/styles.dart';

import 'adminAddAccountingHead.dart';
import 'adminAddExpense.dart';
import 'adminAddInsurance.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getSavedInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: primaryAdminColor),
              child: Container(
                color: primaryAdminColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Flexible(
                      child: CircleAvatar(
                        radius: 40,
                        child: Image(
                          image: AssetImage('assets/head_ic.png'),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    ),
                    Consumer<AdminController>(
                      builder: (context, value, child) {
                        return Text(
                          value.name.toString().toUpperCase(),
                          style: title,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: 'update password',
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryAdminColor,
                          // shape: const StadiumBorder(),
                        ),
                        onPressed: () {},
                        child: const Text('New Password'),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 8),
                  Expanded(
                    child: Tooltip(
                      message: 'logout from account',
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryAdminColor,
                        ),
                        onPressed: () {},
                        child: const Text('Logout'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            DrawerItem(
                icon: Icons.home_work_rounded,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => AdminAddRegional(),
                    ),
                  );
                },
                title: 'Add Regional'),
            DrawerItem(
                icon: Icons.add_home_work_sharp,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AdminAddUnit(),
                    ),
                  );
                },
                title: 'Add Unit'),
            DrawerItem(
                icon: Icons.home_work,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AdminViewRegionalList(),
                    ),
                  );
                },
                title: 'Regional List'),
            DrawerItem(
                icon: Icons.account_balance,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AdminAddAccountingHead(),
                    ),
                  );
                },
                title: 'Accounting Head'),
            // DrawerItem(
            // icon: Icons.document_scanner, onTap: () {}, title: 'Projects'),
            DrawerItem(
                icon: Icons.security,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AdminAddInsurance(),
                    ),
                  );
                },
                title: 'Insurance'),
            DrawerItem(
                icon: Icons.send,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const AdminSendMessages(),
                    ),
                  );
                },
                title: 'Send Message'),
            DrawerItem(
                icon: Icons.savings_rounded, onTap: () {}, title: 'Profit'),
            /*   DrawerItem(
                icon: Icons.add_home_work_sharp,
                onTap: () {},
                title: 'Add Unit'), */
          ],
        ),
      ),
      appBar: AppBar(
        /*   actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.message),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                // right: 5,
                // top: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Consumer<AdminController>(
                    builder: (context, myType, child) {
                      return const Text('');
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 8,
          )
          // const VerticalDivider(),
        ], */
        title: const Text('Admin'),
        // centerTitle: true,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: primaryAdminColor),
        backgroundColor: primaryAdminColor,
      ),
      body: Consumer<AdminController>(builder: (context, val, child) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Text(
                          val.name.toString().toUpperCase(),
                          style: titleblack,
                        ),
                      ),
                      Consumer<AdminController>(
                        builder: (context, value, child) {
                          return Tooltip(
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
                                                //await value.logout(context);
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
                          );
                        },
                      ),
                    ],
                  ) /*  Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /*   const Icon(
                      Icons.home,
                      color: Colors.white,
                    ), */
                    /*    const VerticalDivider(), */
                    Text(
                      val.regionalName,
                      style: title,
                    )
                  ],
                ), */
                  ),
            ),
            Row(
              children: [
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AdminMedicalAid(),
                        ),
                      );
                    },
                    description: 'View Medical Aid',
                    heading: 'MEDICAL AID',
                    image: 'assets/medicalaid.png',
                  ),
                ),
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AdminAddGrant(),
                        ),
                      );
                    },
                    description: 'View grant details ',
                    heading: 'GRANT',
                    image: 'assets/grantshow.png',
                  ),
                ),
              ],
            ),

            /*   SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctc) => const RegionalViewGrant(),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        // elevation: 5,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Image(
                                color: Colors.black,
                                image: AssetImage('assets/grantshow.png'),
                                height: 80,
                              ),
                              const Divider(),
                              Text(
                                'GRANT',
                                style: titleblack,
                              ),
                              const Spacer(),
                              const Text(
                                'View grant details and tranfer to unit',
                                style: TextStyle(
                                    color: Colors.black87, letterSpacing: 2),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ), */
            Row(
              children: [
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => AdminBankLinkage(),
                        ),
                      );
                    },
                    description: 'View banklinkage ',
                    heading: 'BANK LINKAGE',
                    image: 'assets/pay.png',
                  ),
                ),
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AdminSessFundTransfer(),
                        ),
                      );
                    },
                    description: 'View SESS fund',
                    heading: 'SESS FUND',
                    image: 'assets/study.png',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AdminAddIncome(),
                        ),
                      );
                    },
                    description: 'View income ',
                    heading: 'INCOME',
                    image: 'assets/income.png',
                  ),
                ),
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const AdminAddExpense(),
                        ),
                      );
                    },
                    description: 'View expense ',
                    heading: 'EXPENSE',
                    image: 'assets/expenseicon.png',
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

class DrawerItem extends StatelessWidget {
  DrawerItem(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.title});
  String title;
  IconData icon;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: primaryAdminColor,
            child: Icon(
              icon,
              color: Colors.white,
            ),
          ),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_sharp),
        ),
      ),
    );
  }
}

class RegionHomeCard extends StatelessWidget {
  RegionHomeCard(
      {super.key,
      required this.onTap,
      required this.heading,
      required this.image,
      required this.description});
  void Function()? onTap;
  String heading;
  String image;
  String description;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 2,
          // elevation: 5,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Image(
                  color: Colors.black87,
                  image: AssetImage(image),
                  height: 60,
                ),
                const Divider(),
                Text(
                  heading,
                  style: titleblack,
                ),
                const SizedBox(height: 5),
                FittedBox(
                  child: Text(
                    description.toLowerCase(),
                    style: const TextStyle(
                        color: Color.fromARGB(138, 0, 0, 0),
                        letterSpacing: 1,
                        fontSize: 14),
                  ),
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
