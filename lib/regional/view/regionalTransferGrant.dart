import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalTransferGrant extends StatefulWidget {
  RegionalTransferGrant(
      {super.key,
      required this.grantid,
      required this.grantamount,
      required this.grantdate,
      required this.granttype});
  String grantid;
  String grantdate;
  String granttype;
  String grantamount;
  @override
  State<RegionalTransferGrant> createState() => _RegionalTransferGrantState();
}

class _RegionalTransferGrantState extends State<RegionalTransferGrant> {
  var unitpassbook = '';

  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false)
        .getUnits(context, widget.grantid);
  }

  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Grant'),
        backgroundColor: primaryRegionColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Card(
          child: Container(
            // height: MediaQuery.of(context).size.height / 4,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Items(value: widget.grantdate, titile: 'Grant Date'),
                const Divider(color: Colors.transparent),
                Items(value: widget.granttype, titile: 'Grant Type'),
                const Divider(color: Colors.transparent),
                Items(value: widget.grantamount, titile: 'Grant Amount'),
                const Divider(color: Colors.transparent),
                const Divider(),
                Text(
                  'Choose Unit',
                  style: titleblack,
                ),
                const Divider(),
                Consumer<RegionalController>(
                  builder: (context, myType, child) {
                    return DropDownTextField(
                      onChanged: (value) {
                        setState(() {
                          unitpassbook = value.value;
                        });
                      },
                      dropDownList: myType.unitList,
                    );
                  },
                ),
                const SizedBox(height: 8),
                TextField(
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
                ),
                const Divider(color: Colors.transparent),
                Consumer<RegionalController>(
                  builder: (context, myType, child) {
                    return ElevatedButton(
                      onPressed: () async {
                        await myType.transferGrant(
                            context: context,
                            grantid: widget.grantid,
                            grantdate: widget.grantdate,
                            type: widget.granttype,
                            amount: widget.grantamount,
                            transferdate: date.text,
                            unitpassbookno: unitpassbook);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryRegionColor),
                      child: const Text('Transfer'),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
