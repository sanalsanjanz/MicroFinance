import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalAddBankLinkage extends StatefulWidget {
  RegionalAddBankLinkage({super.key, required this.grantid});
  String grantid;

  @override
  State<RegionalAddBankLinkage> createState() => _RegionalAddBankLinkageState();
}

class _RegionalAddBankLinkageState extends State<RegionalAddBankLinkage> {
  var unitpassbook = '';

  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false).regionalGetUnits();
  }

  TextEditingController date = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController period = TextEditingController();
  TextEditingController pdate = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: MediaQuery.of(context).size.height / 4,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Choose Unit',
                style: titleblack,
              ),
              Consumer<RegionalController>(
                builder: (context, myType, child) {
                  return DropDownTextField(
                    onChanged: (value) {
                      setState(() {
                        unitpassbook = value.value;
                      });
                    },
                    dropDownList: myType.regionalUnitList,
                  );
                },
              ),
              const SizedBox(height: 8),
              TextField(
                controller: amount,
                decoration: const InputDecoration(hintText: 'Enter Amount'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: period,
                decoration: const InputDecoration(
                  hintText: 'Enter Period',
                  suffixText: 'Month',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: pdate,
                decoration: const InputDecoration(
                  hintText: 'Payment Date',
                  suffixText: '1-30',
                ),
              ),
              const SizedBox(height: 8),
              const TextField(
                readOnly: true,
                decoration: InputDecoration(
                    hintText: '12% Interest',
                    hintStyle: TextStyle(color: Colors.blue)),
              ),
              const SizedBox(height: 8),
              /*  TextField(
                controller: date,
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
                      date.text = formattedDate;
                    });
                  } else {}
                },
              ), */
              const Divider(color: Colors.transparent),
              Consumer<RegionalController>(
                builder: (context, myType, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      await myType.regionalAddBankLinkage(
                          context: context,
                          amount: amount.text,
                          unitPassbook: unitpassbook,
                          period: period.text,
                          pdate: pdate.text);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryRegionColor),
                    child: const Text('Add'),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
