import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitRegisterNonMember extends StatefulWidget {
  const UnitRegisterNonMember({super.key});

  @override
  State<UnitRegisterNonMember> createState() => _UnitRegisterNonMemberState();
}

class _UnitRegisterNonMemberState extends State<UnitRegisterNonMember> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false)
        .getAllPresident(context: context);
  }

  String presidentid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register Non Member'),
          backgroundColor: primaryUnitColor,
        ),
        body: Consumer<UnitControll>(builder: (context, value, child) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text('Enter Details'),
                const SizedBox(
                  height: 20,
                ),
                DropDownTextField(
                  onChanged: (value) {
                    setState(() {
                      presidentid = value.value;
                    });
                  },
                  enableSearch: true,
                  dropDownList: value.presidentList,
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: numberController,
                  decoration: const InputDecoration(hintText: 'Phone number'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryUnitColor),
                  onPressed: () async {
                    await value.unitRegisterNonMemeber(context,
                        shg: presidentid,
                        number: numberController.text,
                        mailid: nameController.text);
                  },
                  child: const Text("Add Member"),
                ),
              ],
            ),
          );
        }));
  }
}
