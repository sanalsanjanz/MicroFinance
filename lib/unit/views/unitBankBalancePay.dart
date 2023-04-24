// ignore_for_file: file_names, must_be_immutable

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitHome.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitBankPayment extends StatefulWidget {
  const UnitBankPayment({super.key});

  @override
  State<UnitBankPayment> createState() => _UnitBankPaymentState();
}

class _UnitBankPaymentState extends State<UnitBankPayment> {
  Widget space = const Divider(
    color: Colors.transparent,
  );
  TextEditingController dateInput1 = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  TextEditingController interest = TextEditingController();
  TextEditingController bankname = TextEditingController();
  String bank2 = '';

  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
        .unitgetAlldata(context: context);
    Provider.of<UnitControll>(context, listen: false).getAllBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) => const UnitHome()),
                (route) => false);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: primaryUnitColor,
        title: const Text('Bank Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child:
                      Consumer<UnitControll>(builder: (context, value, child) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.issetamountclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color: value.isintresest
                              ? primaryColor
                              : Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(13),
                        duration: const Duration(seconds: 1),
                        child: const Center(
                          child: Text(
                            'Amount Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const VerticalDivider(),
                Expanded(
                  child: Consumer<UnitControll>(builder: (context, value, ch) {
                    return InkWell(
                      splashColor: Colors.transparent,
                      onTap: () {
                        value.issetinterestclicked();
                      },
                      child: AnimatedContainer(
                        decoration: BoxDecoration(
                          color:
                              value.isamount ? primaryColor : Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.all(13),
                        duration: const Duration(milliseconds: 100),
                        child: const Center(
                          child: Text(
                            'Interest Payment',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Expanded(
                child: Consumer<UnitControll>(builder: (context, value, ch) {
              return value.isamount
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: dateInput1,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "From Date"),
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
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    dateInput1.text = formattedDate;
                                  });
                                } else {}
                              },
                            ),
                            space,
                            TextField(
                              controller: interest,
                              decoration: const InputDecoration(
                                  helperText: 'Interest',
                                  hintText: 'enter interest %'),
                            ),
                            space,
                            TextField(
                              controller: bankname,
                              decoration: const InputDecoration(
                                  helperText: 'Bank Name',
                                  hintText: 'enter bank name'),
                            ),
                            space,
                            Items(value: value.savings, titile: 'Savings'),
                            space,
                            space,
                            ElevatedButton(
                              onPressed: () async {
                                await value.unitsendBankPayment(
                                    context: context,
                                    bank: bankname.text,
                                    interest: interest.text,
                                    amount: value.savings,
                                    date: dateInput1.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: shadeUnitColor),
                              child: const Text('Pay'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            const Divider(
                              color: Colors.transparent,
                            ),
                            const Text('Choose Date'),
                            const Divider(),
                            TextField(
                              controller: dateInput2,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.calendar_today),
                                  labelText: "From Date"),
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
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);

                                  setState(() {
                                    dateInput2.text = formattedDate;
                                  });
                                } else {}
                              },
                            ),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            const Text('Choose Bank'),
                            const Divider(),
                            DropDownTextField(
                              onChanged: (value) {
                                setState(() {
                                  bank2 = value.name;
                                });
                              },
                              dropDownList: value.banks,
                            ),
                            const Divider(
                              color: Colors.transparent,
                            ),
                            const TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText: 'Bank Interest',
                                  icon: Icon(Icons.percent)),
                            ),
                            const Divider(
                              height: 20,
                              color: Colors.transparent,
                            ),
                            SizedBox(
                              width: 100,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: shadeUnitColor),
                                  onPressed: () async {
                                    await value.unitsendBankInterestrPayment(
                                        context: context,
                                        bank: bank2,
                                        interest: interest.text,
                                        date: dateInput2.text);
                                  },
                                  child: const Text('Pay')),
                            )
                          ],
                        ),
                      ),
                    );
            }))
          ],
        ),
      ),
    );
  }
}
