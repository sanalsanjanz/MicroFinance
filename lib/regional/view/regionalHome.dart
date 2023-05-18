import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionalMedicalAidView.dart';
import 'package:sacco_management/regional/view/regionalBankLinkage.dart';
import 'package:sacco_management/regional/view/regionalMessaageView.dart';
import 'package:sacco_management/regional/view/regionalSessFund.dart';
import 'package:sacco_management/regional/view/regionalViewGrant.dart';

class RegionalHome extends StatefulWidget {
  const RegionalHome({super.key});

  @override
  State<RegionalHome> createState() => _RegionalHomeState();
}

class _RegionalHomeState extends State<RegionalHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false).getsaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              color: primaryRegionColor,
            ))
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const RegionalMessagesView(),
                      ),
                    );
                  },
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
                  child: Consumer<RegionalController>(
                    builder: (context, myType, child) {
                      return Text(myType.messagecount);
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
        ],
        title: const Text('Regional'),
        // centerTitle: true,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: primaryRegionColor),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              color: const Color.fromARGB(64, 8, 130, 149),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    const VerticalDivider(),
                    Text(
                      val.regionalName,
                      style: title,
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RegionHomeCard(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const RegionalMedicalAidView(),
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
                          builder: (ctc) => const RegionalViewGrant(),
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
                          builder: (ctx) => const RegionalBankLinkage(),
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
                          builder: (ctc) => const RegionalSessFund(),
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
                          builder: (ctc) => const RegionalViewGrant(),
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
                          builder: (ctc) => const RegionalViewGrant(),
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
