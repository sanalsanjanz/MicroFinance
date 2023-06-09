import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class AdminSessFundTransfer extends StatefulWidget {
  const AdminSessFundTransfer({super.key});

  @override
  State<AdminSessFundTransfer> createState() => _AdminSessFundTransferState();
}

class _AdminSessFundTransferState extends State<AdminSessFundTransfer> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false).getSessDetails();
  }

  String passbook = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAdminColor,
        title: const Text('Sess Fund'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AdminController>(builder: (context, data, child) {
          return Column(
            children: [
              const Divider(color: Colors.transparent),
              const Center(
                child: Text('Total Sess Fund'),
              ),
              const Divider(color: Colors.transparent),
              Center(
                child: Text(data.sessAmount.toString()),
              ),
              const Divider(color: Colors.transparent),
              DropDownTextField(
                initialValue: 'Choose Regional',
                dropDownList: data.regionalList2,
                onChanged: (value) {
                  setState(() {
                    passbook = value.value;
                  });
                },
              ),
              const Divider(color: Colors.transparent),
              const Divider(color: Colors.transparent),
              const Items(value: '20000', titile: 'Loan Amount'),
              const Divider(color: Colors.transparent),
              const Items(value: '20 Months', titile: 'Loan Period'),
              const Divider(color: Colors.transparent),
              const Divider(color: Colors.black45),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: shadedRegionColor),
                  onPressed: () async {
                    await data.addSessFund(
                        context: context, regionpassbookno: passbook);
                    /*   await val.regionalTransferSessFund(
                        context: context,
                        mid: data['mid'],
                      ); */
                  },
                  child: const Text('Add'),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
