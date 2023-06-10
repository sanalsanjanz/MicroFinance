import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class AdminAddInsurance extends StatefulWidget {
  const AdminAddInsurance({super.key});

  @override
  State<AdminAddInsurance> createState() => _AdminAddInsuranceState();
}

class _AdminAddInsuranceState extends State<AdminAddInsurance> {
  TextEditingController dateInput2 = TextEditingController();
  TextEditingController cname = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getInsurance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance'),
        backgroundColor: primaryAdminColor,
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cname,
                decoration: const InputDecoration(hintText: 'Company name'),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<AdminController>(builder: (context, va, child) {
                return Items(value: va.insurance, titile: 'Amount');
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
              Consumer<AdminController>(builder: (context, va, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryAdminColor),
                  onPressed: () async {
                    await va.transferInsurance(
                        context: context,
                        cname: cname.text,
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
