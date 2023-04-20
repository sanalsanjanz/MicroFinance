// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitPaySessFund extends StatefulWidget {
  const UnitPaySessFund({Key? key}) : super(key: key);

  @override
  State<UnitPaySessFund> createState() => _UnitPaySessFundState();
}

class _UnitPaySessFundState extends State<UnitPaySessFund> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false).fetchtotalSess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Pay Sess'),
      ),
      body: SizedBox(
        height: 200,
        width: double.maxFinite,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Items(
                    value: Provider.of<UnitControll>(context).unitsessAmount,
                    titile: 'Payment Amount'),
                const Divider(color: Colors.transparent),
                const Divider(color: Colors.transparent),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: shadeUnitColor),
                    onPressed: () async {
                      await Provider.of<UnitControll>(context, listen: false)
                          .unitPaySessFund(context: context, sessid: '');
                    },
                    child: const Text('Pay Fund'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
