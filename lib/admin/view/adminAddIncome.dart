import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminAddIncome extends StatefulWidget {
  const AdminAddIncome({super.key});

  @override
  State<AdminAddIncome> createState() => _AdminAddIncomeState();
}

class _AdminAddIncomeState extends State<AdminAddIncome> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false)
        .getAccountingHead('income');
  }

  final TextEditingController dateInput1 = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  String type = '';
  String accountingHead = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryAdminColor,
          title: const Text('Add Income'),
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
                      dropDownList: myType.income,
                    ))
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Icome Type',
                        style: titleblack,
                      ),
                    ),
                    const Text('  :  '),
                    Expanded(
                        child: DropDownTextField(
                      onChanged: (value) {
                        setState(() {
                          type = value.value;
                        });
                      },
                      dropDownList: const [
                        DropDownValueModel(name: 'Chitty', value: 'Chitty'),
                        DropDownValueModel(name: 'Business', value: 'Business'),
                        DropDownValueModel(
                            name: 'Agriculture', value: 'Agriculture'),
                        DropDownValueModel(name: 'Others', value: 'Others'),
                      ],
                    ))
                  ],
                ),
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
                Container(
                  padding: const EdgeInsets.all(15),
                  // height: MediaQuery.of(context).size.width / 3,ss
                  child: TextField(
                    controller: dateInput1,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Transfer Date"),
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
                      await myType.addOtherIncome(
                          context: context,
                          amount: amountController.text,
                          date: dateInput1.text,
                          type: type,
                          accountinghead: accountingHead);
                    },
                    child: const Text('Add Income'))
              ],
            ),
          );
        }));
  }
}
