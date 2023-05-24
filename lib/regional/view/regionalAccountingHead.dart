// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalAccountingHead extends StatefulWidget {
  const RegionalAccountingHead({super.key});

  @override
  State<RegionalAccountingHead> createState() => _RegionalAccountingHeadState();
}

class _RegionalAccountingHeadState extends State<RegionalAccountingHead> {
  bool income = false;
  bool expense = false;
  TextEditingController accountinghead = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounting Head'),
        backgroundColor: primaryRegionColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(color: Colors.transparent),
                const Text(
                  'Choose type',
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(color: Colors.transparent),
                Row(
                  children: [
                    ChoiceChip(
                      selectedColor: primaryColor,
                      label: const Text('Income'),
                      selected: income,
                      onSelected: (value) {
                        setState(() {
                          income = value;
                          expense = false;
                        });
                      },
                    ),
                    const VerticalDivider(),
                    ChoiceChip(
                      selectedColor: primaryColor,
                      label: const Text('Expense'),
                      selected: expense,
                      onSelected: (value) {
                        setState(() {
                          income = false;
                          expense = value;
                        });
                      },
                    ),
                  ],
                ),
                const Divider(color: Colors.transparent),
                const Text(
                  'Enter Accounting Head',
                  style: TextStyle(fontSize: 16),
                ),
                const Divider(color: Colors.transparent),
                TextFormField(
                  style: const TextStyle(fontSize: 15),
                  readOnly: (income || expense) == false ? true : false,
                  controller: accountinghead,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //filled: true,
                      // fillColor: primaryRegionColor,
                      hintText: income
                          ? 'eg : loan interest'
                          : expense
                              ? 'eg : travel'
                              : 'Enter here'),
                ),
                const Divider(color: Colors.transparent),
              ],
            ),
            const Divider(color: Colors.transparent),
            Expanded(
              child: Consumer<RegionalController>(
                  builder: (context, value, child) {
                return FutureBuilder(
                  future: value.getAccountingHead(''),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(children: [
                        Table(
                          border: TableBorder.all(),
                          children: [
                            buildRow(['Income', 'Expense'], isHeader: true),
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: snapshot.data[1]['incomedata'].length >
                                    snapshot.data[0]['expensedata'].length
                                ? snapshot.data[1]['incomedata'].length
                                : snapshot.data[0]['expensedata'].length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data[0]['expensedata'][index];
                              return Table(
                                border: TableBorder.all(color: Colors.black54),
                                children: [
                                  /*   buildRow(['Income', 'Expense'],
                                      isHeader: true), */
                                  buildRow([
                                    index >
                                            snapshot.data[1]['incomedata']
                                                    .length -
                                                1
                                        ? ''
                                        : snapshot.data[1]['incomedata'][index]
                                            ['head'],
                                    index >
                                            snapshot.data[0]['expensedata']
                                                    .length -
                                                1
                                        ? ''
                                        : data['head'],
                                  ])
                                ],
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryRegionColor),
                          onPressed: () async {
                            income == false && expense == false
                                ? Fluttertoast.showToast(
                                    msg: 'please choose type !!',
                                    gravity: ToastGravity.CENTER)
                                : accountinghead.text == ''
                                    ? Fluttertoast.showToast(
                                        msg: 'enter a valid head !!',
                                        gravity: ToastGravity.CENTER)
                                    : await value.addAccountingHead(
                                        context,
                                        income
                                            ? 'Income'
                                            : expense
                                                ? 'Expense'
                                                : '',
                                        accountinghead.text);
                            // value.addsambhadyam(context);
                          },
                          child: const Text('Add Accounting Head'),
                        ),
                      ]);
                    } else {
                      return Center(
                        child: SpinKitFadingCircle(color: primaryColor),
                      );
                    }
                  },
                );
              }),

              /*  Table(
              border: TableBorder.all(),
              children: [
                buildRow(['INCOME', 'EXPENSE'], isHeader: true)
              ],
            ), */
            )
          ],
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
          children: cells.map((cell) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              cell,
              style: isHeader
                  ? const TextStyle(fontWeight: FontWeight.bold)
                  : const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        );
      }).toList());
}
