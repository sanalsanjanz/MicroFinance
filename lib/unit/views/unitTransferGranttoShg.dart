import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitTranferGrantToShg extends StatelessWidget {
  UnitTranferGrantToShg(
      {super.key,
      required this.gdate,
      required this.gtype,
      required this.gamount,
      required this.id});
  String gdate;
  String gamount;
  String gtype;
  String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranfer Grant'),
        backgroundColor: primaryUnitColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [Items(value: gdate, titile: 'Grant Date')],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
