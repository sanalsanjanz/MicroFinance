// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

import '../controller/presidenthomecontroll.dart';

class PresidentGiveSessToUnit extends StatefulWidget {
  const PresidentGiveSessToUnit({super.key});

  @override
  State<PresidentGiveSessToUnit> createState() =>
      _PresidentGiveSessToUnitState();
}

class _PresidentGiveSessToUnitState extends State<PresidentGiveSessToUnit> {
  TextEditingController date2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false).sambhadyam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Transfer Sess to Unit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PresidentController>(
          builder: (context, value, child) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  const Divider(color: Colors.transparent),
                  Container(
                    padding: const EdgeInsets.all(15),
                    // height: MediaQuery.of(context).size.width / 3,
                    child: TextField(
                      controller: date2,
                      decoration: const InputDecoration(
                          icon: Image(
                            height: 40,
                            image: AssetImage('assets/calendar.png'),
                          ),
                          labelText: "Choose Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          //print(pickedDate);
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          //print(formattedDate);
                          setState(() {
                            date2.text = formattedDate;
                          });
                        } else {}
                      },
                    ),
                  ),
                  const Divider(color: Colors.transparent),
                  const Divider(color: Colors.transparent),
                  Items(
                      value: value.paysessAmount.toString(),
                      titile: 'Sess Amount  :'),
                  const Divider(color: Colors.transparent),
                  const Divider(color: Colors.transparent),
                  ElevatedButton(
                    onPressed: () async {
                      await value.paySessToUnit(
                          date: date2.text, context: context);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: const Text('Pay Unit'),
                  ),
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}
