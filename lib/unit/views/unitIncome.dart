// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitIncome extends StatefulWidget {
  const UnitIncome({super.key});

  @override
  State<UnitIncome> createState() => _UnitIncomeState();
}

class _UnitIncomeState extends State<UnitIncome> {
  TextEditingController date = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String type = '';
  String accountinghead = '';
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
            .accountingHeadIncome
            .isEmpty
        ? Provider.of<UnitControll>(context, listen: false)
            .getAccountingHead(type: 'income')
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryUnitColor,
        title: const Text('Unit Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            /*  const Center(
              child: Text(),
            ), */
            Row(children: [
              const Text('Accounting Head'),
              const VerticalDivider(),
              Consumer<UnitControll>(builder: (context, val, chil) {
                return Expanded(
                  child: DropDownTextField(
                    dropDownList: val.accountingHeadIncome,
                    onChanged: (value) {
                      setState(() {
                        accountinghead = value.value;
                      });
                    },
                  ),
                );
              })
            ]),
            const Divider(),
            Row(
              children: [
                const Text('Income Type'),
                const VerticalDivider(),
                Expanded(
                  child: DropDownTextField(
                    onChanged: (value) {
                      setState(() {
                        type = value.value;
                      });
                    },
                    dropDownList: const [
                      DropDownValueModel(name: 'Business', value: 'Business'),
                      DropDownValueModel(name: 'Chitty', value: 'Chitty'),
                      DropDownValueModel(
                          name: 'Agricuture', value: 'Agricuture'),
                      DropDownValueModel(name: 'Others', value: 'Others'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(Icons.monetization_on),
                const VerticalDivider(),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration:
                        const InputDecoration(hintText: 'Add Income Amount'),
                    controller: amountController,
                  ),
                ),
              ],
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(15),
              // height: MediaQuery.of(context).size.width / 3,
              child: TextField(
                controller: date,
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
                      date.text = formattedDate;
                    });
                  } else {}
                },
              ),
            ),
            Consumer<UnitControll>(builder: (context, val, chil) {
              return ElevatedButton(
                onPressed: () async {
                  await val.addIncome(
                      context: context,
                      date: date.text,
                      type: type,
                      amount: amountController.text,
                      accountinghead: accountinghead);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Text('Add Income'),
              );
            })
          ],
        ),
      ),
    );
  }
}
