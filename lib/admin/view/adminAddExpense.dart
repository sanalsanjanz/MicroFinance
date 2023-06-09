import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminAddExpense extends StatefulWidget {
  const AdminAddExpense({super.key});

  @override
  State<AdminAddExpense> createState() => _AdminAddExpenseState();
}

class _AdminAddExpenseState extends State<AdminAddExpense> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false)
        .getAccountingHead('expense');
  }

  final TextEditingController dateInput1 = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String type = '';
  String accountingHead = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryAdminColor,
          title: const Text('Add Expense'),
        ),
        body: Consumer<AdminController>(builder: (context, myType, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Accounting Head',
                        style: titleblack,
                      ),
                    ),
                    const Text('  :  '),
                    Expanded(
                        child: DropDownTextField(
                      onChanged: (value) {
                        setState(() {
                          accountingHead = value.value;
                        });
                      },
                      dropDownList: myType.expense,
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Expense Reason',
                        style: titleblack,
                      ),
                    ),
                    const Text('  :  '),
                    Expanded(
                        child: TextField(
                      controller: reasonController,
                      // keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Expense Reason'),
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Amount',
                        style: titleblack,
                      ),
                    ),
                    const Text('  :  '),
                    Expanded(
                        child: TextField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(hintText: 'Enter Amount'),
                    ))
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(15),
                  // height: MediaQuery.of(context).size.width / 3,ss
                  child: TextField(
                    controller: dateInput1,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), labelText: "Date"),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        //print(pickedDate);
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);

                        setState(() {
                          dateInput1.text = formattedDate;
                        });
                      } else {}
                    },
                  ),
                ),
                const Divider(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: shadeAdminColor),
                  onPressed: () async {
                    await myType.addExpense(
                        context: context,
                        amount: amountController.text,
                        date: dateInput1.text,
                        reason: reasonController.text,
                        accountinghead: accountingHead);
                  },
                  child: const Text('Add Expense'),
                ),
              ],
            ),
          );
        }));
  }
}
