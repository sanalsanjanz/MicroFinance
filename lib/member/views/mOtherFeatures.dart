// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/controllers/memberConfigController.dart';
import 'package:sacco_management/member/views/memberBankLinkage.dart';
import 'package:sacco_management/member/views/memberGrant.dart';
import 'package:sacco_management/member/views/memberInsurance.dart';
import 'package:sacco_management/member/views/memberSessFund.dart';
import 'package:sacco_management/member/views/memberfestivalFund.dart';
import 'package:sacco_management/member/views/myshares.dart';
import 'package:sacco_management/widgets/reusableOptionCard.dart';

class MOtherFetures extends StatelessWidget {
  const MOtherFetures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: memberPrimary,
        title: const Text('Other Features'),
        elevation: 0,
      ),
      body: Consumer<MemberConfigController>(builder: (context, val, child) {
        return ListView(
          children: [
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.fest == 'true' ? true : false,
                titile: 'Festival Fund',
                subtitle: 'view festival fund',
                letter: 'F',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MemberFestivalFund(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.sess == 'true' ? true : false,
                titile: 'Sess Fund',
                subtitle: 'view Sess fund',
                letter: 'S',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MemberSessFund(),
                    ),
                  );
                }),
            /*  PresidentOptionalCard(
                color: Colors.blueGrey[100],
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
                }), */
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.insu == 'true' ? true : false,
                titile: 'Insurance',
                subtitle: 'insurance details',
                letter: 'I',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MemberInsurance(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.gra == 'true' ? true : false,
                titile: 'Grants',
                subtitle: 'view grants',
                letter: 'G',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MemberGrant(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.bank == 'true' ? true : false,
                titile: 'Bank Linkage',
                subtitle: 'bank linkage',
                letter: 'B',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const MemberBankLinkage(),
                    ),
                  );
                }),
            PresidentOptionalCard(
                color: Colors.blueGrey[100],
                visibility: val.shar == 'true' ? true : false,
                titile: 'Shares',
                subtitle: 'view shares',
                letter: 'S',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => const MyShares(),
                    ),
                  );
                }),
            /*    PresidentOptionalCard(color: Colors.blueGrey[100],
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
