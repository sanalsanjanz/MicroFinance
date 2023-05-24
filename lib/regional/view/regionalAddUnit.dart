import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalAddUnit extends StatelessWidget {
  RegionalAddUnit({super.key});
  final TextEditingController unitName = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        title: const Text('Add Unit'),
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.black45,

                /*  child: Image(
                  color: primaryRegionColor, */
                backgroundImage: AssetImage('assets/unitprofile.png'),
              ),
              const Divider(),
              Text(
                val.regionalName.toUpperCase(),
                style: titleblack,
              ),
              const Divider(),
              /*  TextField(
                readOnly: true,
                decoration: InputDecoration(
                    hintText: val.regionalName,
                    hintStyle: const TextStyle(color: Colors.blue)),
              ), */
              const SizedBox(height: 10),
              TextField(
                controller: unitName,
                decoration: const InputDecoration(hintText: 'Unit Name'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: mobileNumber,
                decoration: const InputDecoration(hintText: 'Mobile Number'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: password,
                decoration: const InputDecoration(hintText: 'Password'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRegionColor,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async {
                    await val.regionalAddUnit(
                        context: context,
                        mobile: mobileNumber.text,
                        password: password.text,
                        unitname: unitName.text);
                  },
                  child: const Text('Add Unit'))
            ],
          ),
        );
      }),
    );
  }
}
