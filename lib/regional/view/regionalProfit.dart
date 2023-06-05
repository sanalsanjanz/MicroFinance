import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalProfit extends StatefulWidget {
  const RegionalProfit({super.key});

  @override
  State<RegionalProfit> createState() => _RegionalProfitState();
}

class _RegionalProfitState extends State<RegionalProfit> {
  TextEditingController dateInput2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false).getProfit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profit'),
        backgroundColor: primaryRegionColor,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<RegionalController>(builder: (context, va, child) {
                return Items(
                    value: va.profit,
                    titile: 'Yearly ${va.profitPercentage} % ');
              }),
              Container(
                padding: const EdgeInsets.all(15),
                // height: MediaQuery.of(context).size.width / 3,
                child: TextField(
                  controller: dateInput2,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), labelText: "To Date"),
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
                        dateInput2.text = formattedDate;
                      });
                    } else {}
                  },
                ),
              ),
              Consumer<RegionalController>(builder: (context, va, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRegionColor),
                  onPressed: () async {
                    await va.transferProfit(
                        context: context,
                        amount: va.insurance,
                        date: dateInput2.text);
                  },
                  child: const Text('Transfer'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
