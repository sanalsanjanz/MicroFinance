import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitTranferGrantToShg extends StatefulWidget {
  UnitTranferGrantToShg(
      {super.key,
      required this.gdate,
      required this.gtype,
      required this.gamount,
      required this.id});
  String gdate;
  String gamount;
  String gtype;
  String id;

  @override
  State<UnitTranferGrantToShg> createState() => _UnitTranferGrantToShgState();
}

class _UnitTranferGrantToShgState extends State<UnitTranferGrantToShg> {
  TextEditingController dateInput1 = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false).shglist.isEmpty
        ? Provider.of<UnitControll>(context, listen: false)
            .getallSHG(context: context, opt: 0)
        : '';
  }

  late String shgpassbookno;
  late String shgname;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranfer Grant'),
        backgroundColor: primaryUnitColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Items(value: widget.gdate, titile: 'Grant Date'),
                        const Divider(color: Colors.transparent),
                        Items(value: widget.gtype, titile: 'Grant Type'),
                        const Divider(color: Colors.transparent),
                        Items(value: widget.gamount, titile: 'Grant Amount'),
                        const Divider(color: Colors.transparent),
                        // Items(value: gdate, titile: 'Grant Date'),
                        TextField(
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
                        const Divider(color: Colors.transparent),
                        Row(
                          children: [
                            Icon(Icons.group, color: primaryUnitColor),
                            const VerticalDivider(),
                            Expanded(
                              child: Consumer<UnitControll>(
                                  builder: (context, val, child) {
                                return DropDownTextField(
                                  enableSearch: true,
                                  dropDownList: val.shglist,
                                  onChanged: (va) {
                                    setState(() {
                                      shgname = va.name;
                                      shgpassbookno = va.value;
                                    });
                                    print(shgname + shgpassbookno);
                                  },
                                );
                              }),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.transparent),
                        const Divider(color: Colors.transparent),
                        Consumer<UnitControll>(builder: (context, val, child) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: shadeUnitColor),
                            onPressed: () async {
                              await val.transfergrantunit(
                                  context: context,
                                  grantid: widget.id,
                                  shgname: shgname,
                                  type: widget.gtype,
                                  transdate: dateInput1.text,
                                  amount: widget.gamount,
                                  gdate: widget.gdate,
                                  shgpassbook: shgpassbookno);
                            },
                            child: const Text('TRANSFER'),
                          );
                        }),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
