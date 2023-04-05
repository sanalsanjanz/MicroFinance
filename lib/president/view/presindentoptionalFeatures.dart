// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidentConfigController.dart';
import 'package:sacco_management/president/view/pGrants.dart';
import 'package:sacco_management/president/view/pInsurance.dart';
import 'package:sacco_management/president/view/pMedicalAid.dart';
import 'package:sacco_management/president/view/pSessFund.dart';
import 'package:sacco_management/president/view/presidentFestivalfund.dart';
import 'package:sacco_management/president/view/presidentGiveMeddicalAidToUnit.dart';
import 'package:sacco_management/president/view/presidentGiveSessToUnit.dart';
import 'package:sacco_management/president/view/presidentViewSessFund.dart';
import 'package:sacco_management/president/view/presidentpaysess.dart';
import 'package:sacco_management/widgets/reusableOptionCard.dart';

class PresidentOptionalFeatures extends StatefulWidget {
  const PresidentOptionalFeatures({super.key});

  @override
  State<PresidentOptionalFeatures> createState() =>
      _PresidentOptionalFeaturesState();
}

class _PresidentOptionalFeaturesState extends State<PresidentOptionalFeatures> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentConfigController>(context, listen: false)
        .getPresidentConfig();
  }

  bool sessClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Other Features'),
        elevation: 0,
      ),
      body: Consumer<PresidentConfigController>(builder: (context, val, child) {
        return ListView(
          children: [
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.fest == 'true' ? true : false,
                titile: 'Festival Fund',
                subtitle: 'view festival fund',
                letter: 'F',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PresiderntFestivalFund(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.sess == 'true' ? true : false,
                titile: 'Sess Fund',
                subtitle: 'view Sess fund',
                letter: 'S',
                onTap: () {
                  setState(() {
                    sessClicked = !sessClicked;
                  });
                }),
            Visibility(
              visible: sessClicked,
              child: AnimatedContainer(
                color: shadeprimaryColor,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(10),
                // color: shadeprimaryColor,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PSessFund(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('ADD SESS FUND'),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => const PresidentGiveSessToUnit(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('GIVE SESS TO UNIT'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PresidentViewSessFund(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('VIEW SESS FUND'),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PresidentPaySessFund(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('PAY SESS FUND'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.medi == 'true' ? true : false,
                titile: 'Medical Aid',
                subtitle: 'medical aid details',
                letter: 'M',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PMedicalAid(),
                    ),
                  );
                }),
            Visibility(
              visible: sessClicked,
              child: AnimatedContainer(
                color: shadeprimaryColor,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(10),
                // color: shadeprimaryColor,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => PMedicalAid(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('ADD MEDICAL AID'),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) =>
                                const PresidentGiveMedicalAidToUnit(),
                          ),
                        );
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Center(
                            child: Text('GIVE MEDICAL AID TO UNIT'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.insu == 'true' ? true : false,
                titile: 'Insurance',
                subtitle: 'insurance details',
                letter: 'I',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PInsurance(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.gra == 'true' ? true : false,
                titile: 'Grants',
                subtitle: 'view grants',
                letter: 'G',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PGrants(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.bank == 'true' ? true : false,
                titile: 'Bank Linkage',
                subtitle: 'bank linkage',
                letter: 'B',
                onTap: () {}),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.shar == 'true' ? true : false,
                titile: 'Shares',
                subtitle: 'view shares',
                letter: 'S',
                onTap: () {}),
            PresidentOptionalCard(
                color: primaryColor,
                visibility: val.profit,
                titile: 'Profit',
                subtitle: 'view profit',
                letter: 'P',
                onTap: () {})
          ],
        );
      }),
    );
  }
}
