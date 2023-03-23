import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberConfigController.dart';
import 'package:sacco_management/widgets/reusableOptionCard.dart';

class MOtherFetures extends StatelessWidget {
  const MOtherFetures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Other Features'),
        elevation: 0,
      ),
      body: Consumer<MemberConfigController>(builder: (context, val, child) {
        return ListView(
          children: [
            PresidentOptionalCard(
                visibility: val.fest == 'true' ? true : false,
                titile: 'Festival Fund',
                subtitle: 'view festival fund',
                letter: 'F',
                onTap: () {
                  /*   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PresiderntFestivalFund(),
                    ),
                  ); */
                }),
            PresidentOptionalCard(
                visibility: val.sess == 'true' ? true : false,
                titile: 'Sess Fund',
                subtitle: 'view Sess fund',
                letter: 'S',
                onTap: () {
                  /*     Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PSessFund(),
                    ),
                  ); */
                }),
            PresidentOptionalCard(
                visibility: val.medi == 'true' ? true : false,
                titile: 'Medical Aid',
                subtitle: 'medical aid details',
                letter: 'M',
                onTap: () {
                  /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PMedicalAid(),
                    ),
                  ); */
                }),
            PresidentOptionalCard(
                visibility: val.insu == 'true' ? true : false,
                titile: 'Insurance',
                subtitle: 'insurance details',
                letter: 'I',
                onTap: () {
                  /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PInsurance(),
                    ),
                  ); */
                }),
            PresidentOptionalCard(
                visibility: val.gra == 'true' ? true : false,
                titile: 'Grants',
                subtitle: 'view grants',
                letter: 'G',
                onTap: () {
                  /*  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => PGrants(),
                    ),
                  ); */
                }),
            PresidentOptionalCard(
                visibility: val.bank == 'true' ? true : false,
                titile: 'Bank Linkage',
                subtitle: 'bank linkage',
                letter: 'B',
                onTap: () {}),
            PresidentOptionalCard(
                visibility: val.shar == 'true' ? true : false,
                titile: 'Shares',
                subtitle: 'view shares',
                letter: 'S',
                onTap: () {}),
            /*    PresidentOptionalCard(
                visibility: val.profit,
                titile: 'Profit',
                subtitle: 'view profit',
                letter: 'P',
                onTap: () {}) */
          ],
        );
      }),
    );
  }
}
