// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresidentExpense extends StatefulWidget {
  const PresidentExpense({super.key});

  @override
  State<PresidentExpense> createState() => _PresidentExpenseState();
}

class _PresidentExpenseState extends State<PresidentExpense> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false).expense.isEmpty
        ? Provider.of<PresidentController>(context, listen: false)
            .getPresidentAccountingHead()
        : '';
  }

  TextEditingController amoutController = TextEditingController();

  TextEditingController date2 = TextEditingController();

  TextEditingController reasonController = TextEditingController();
  String accountingHeader = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PresidentController>(
          builder: (context, value, child) {
            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text('Add Details of Expense'),
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.edit), const VerticalDivider(),
                  //const Text('Expense Reason'),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          hintText: 'Add Expense reason here...'),
                      maxLines: 3,
                      controller: reasonController,
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Text('Accounting head'),
                  const VerticalDivider(),
                  Expanded(
                    child: DropDownTextField(
                      dropDownList: value.expense,
                      onChanged: (item) {
                        setState(() {
                          accountingHeader = item.value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Divider(),
              Row(
                children: [
                  const Icon(Icons.monetization_on),
                  const VerticalDivider(),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Add Expense Amount'),
                      controller: amoutController,
                    ),
                  ),
                ],
              ),
              const Divider(),
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
              ElevatedButton(
                onPressed: () async {
                  await value.addExpense(
                      accountinghead: accountingHeader,
                      context: context,
                      reason: reasonController.text,
                      amount: amoutController.text,
                      date: date2.text);
                },
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                child: const Text('Add Expense'),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
