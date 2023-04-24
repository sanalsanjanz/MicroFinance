import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitTransferInsurance extends StatefulWidget {
  const UnitTransferInsurance({Key? key}) : super(key: key);

  @override
  State<UnitTransferInsurance> createState() => _UnitTransferInsuranceState();
}

class _UnitTransferInsuranceState extends State<UnitTransferInsurance> {
  TextEditingController dateInput2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
        .unitgetAlldata(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryUnitColor,
        title: const Text('Transfer Insurance'),
      ),
      body: Column(
        children: [
          Consumer<UnitControll>(
            builder: (context, value, child) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Divider(
                        color: Colors.transparent,
                      ),
                      Items(value: value.insurance, titile: 'Amount'),
                      const Divider(color: Colors.transparent),
                      TextField(
                        controller: dateInput2,
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
                              dateInput2.text = formattedDate;
                            });
                          } else {}
                        },
                      ),
                      const Divider(color: Colors.transparent),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: shadeUnitColor),
                            onPressed: () async {
                              await value.unitTranferInsurance(
                                  context: context,
                                  amount: value.insurance,
                                  date: dateInput2.text);
                            },
                            child: const Text('Transfer')),
                      )
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
