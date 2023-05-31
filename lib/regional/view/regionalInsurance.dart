import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalInsurance extends StatefulWidget {
  const RegionalInsurance({super.key});

  @override
  State<RegionalInsurance> createState() => _RegionalInsuranceState();
}

class _RegionalInsuranceState extends State<RegionalInsurance> {
  TextEditingController dateInput2 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false).getInsurance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance'),
        backgroundColor: primaryRegionColor,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<RegionalController>(builder: (context, va, child) {
                return Items(value: va.insurance, titile: 'Amount');
              }),
              ReusableDatePicker(
                dateInput2: dateInput2,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRegionColor),
                  onPressed: () {},
                  child: const Text('Transfer'))
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableDatePicker extends StatefulWidget {
  ReusableDatePicker({
    required this.dateInput2,
    super.key,
  });
  TextEditingController dateInput2 = TextEditingController();
  @override
  State<ReusableDatePicker> createState() => _ReusableDatePickerState();
}

class _ReusableDatePickerState extends State<ReusableDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      // height: MediaQuery.of(context).size.width / 3,
      child: TextField(
        // controller: dateInput2,
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
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            //print(formattedDate);
            setState(() {
              widget.dateInput2.text = formattedDate;
            });
          } else {}
        },
      ),
    );
  }
}
