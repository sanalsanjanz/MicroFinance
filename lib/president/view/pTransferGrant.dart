import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class PTransferGrant extends StatefulWidget {
  PTransferGrant(
      {super.key,
      required this.id,
      required this.date,
      required this.type,
      required this.amount});
  String date;
  String type;
  String amount;
  String id;

  @override
  State<PTransferGrant> createState() => _PTransferGrantState();
}

class _PTransferGrantState extends State<PTransferGrant> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false)
            .memmbpassbook
            .isEmpty
        ? Provider.of<PresidentController>(context, listen: false)
            .membpassbook()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<PresidentController>(builder: (context, val, chi) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Items(value: widget.date, titile: 'Grant Date'),
              const SizedBox(
                height: 10,
              ),
              Items(value: widget.type, titile: 'Grant Type'),
              const SizedBox(
                height: 10,
              ),
              Items(value: widget.amount, titile: 'Grant Amount'),
              const SizedBox(
                height: 10,
              ),
              Items(value: DateTime.now().toString(), titile: 'Transfer Date'),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Select Member',
              ),
              const Divider(),
              Row(
                children: [
                  const VerticalDivider(),
                  Expanded(
                    child: DropDownTextField(
                      dropDownList: val.memmbpassbook,
                      onChanged: (value) {
                        val.setMemberpassbook(value.value.toString());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    val.tranferGeanttoMember(
                        grantid: widget.id,
                        transferdate: widget.date,
                        type: widget.type,
                        amount: widget.amount,
                        context: context);
                  },
                  child: const Text('Approve'))
            ],
          ),
        );
      }),
    );
  }
}
