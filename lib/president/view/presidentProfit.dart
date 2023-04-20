// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

import '../controller/presidenthomecontroll.dart';

class PresidentProfit extends StatefulWidget {
  const PresidentProfit({super.key});

  @override
  State<PresidentProfit> createState() => _PresidentProfitState();
}

class _PresidentProfitState extends State<PresidentProfit> {
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
        title: const Text('Profit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PresidentController>(
          builder: (context, value, child) {
            return Column(children: [
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
              Items(
                  value: value.payunitAmount.toInt().toString(),
                  titile: '15 % of sambadhyam is'),
              const Divider(color: Colors.transparent),
              ElevatedButton(
                onPressed: () async {
                  await value.payUnit(date: date2.text, context: context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Text('Pay Unit'),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
