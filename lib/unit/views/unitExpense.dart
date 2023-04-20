// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitExpense extends StatefulWidget {
  const UnitExpense({super.key});

  @override
  State<UnitExpense> createState() => _UnitExpenseState();
}

class _UnitExpenseState extends State<UnitExpense> {
  TextEditingController date = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String type = '';
  String accountinghead = '';
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
            .accountingHeadExpense
            .isEmpty
        ? Provider.of<UnitControll>(context, listen: false)
            .getAccountingHead(type: 'expense')
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryUnitColor,
        title: const Text('Unit Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text('Expense Details'),
              ),
              Row(children: [
                const Text('Accounting Head'),
                const VerticalDivider(),
                Consumer<UnitControll>(builder: (context, val, chil) {
                  return Expanded(
                    child: DropDownTextField(
                      dropDownList: val.accountingHeadExpense,
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
                  const Text('Expense reason'),
                  const VerticalDivider(),
                  Expanded(
                    child: TextField(
                      controller: reasonController,
                      onChanged: (value) {
                        setState(() {
                          type = reasonController.text;
                        });
                      },
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
                          const InputDecoration(hintText: 'Add Expense Amount'),
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
                    await val.addExpense(
                        context: context,
                        date: date.text,
                        type: type,
                        amount: amountController.text,
                        accountinghead: accountinghead);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor),
                  child: const Text('Add Expense'),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
