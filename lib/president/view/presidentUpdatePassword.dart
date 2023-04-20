// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresidentUpdatePassword extends StatefulWidget {
  const PresidentUpdatePassword({super.key});

  @override
  State<PresidentUpdatePassword> createState() =>
      _PresidentUpdatePasswordState();
}

class _PresidentUpdatePasswordState extends State<PresidentUpdatePassword> {
  TextEditingController newpassController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    newpassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: primaryColor),
        title: const Text('Change Password'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            const SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: Image(
                  fit: BoxFit.cover, image: AssetImage('assets/head_ic.png')),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .02,
            ),
            TextField(
              controller: newpassController,
              decoration: const InputDecoration(hintText: 'New password'),
            ),
            const Divider(color: Colors.transparent),
            const Divider(color: Colors.transparent),
            Consumer<PresidentController>(
              builder: (context, value, child) {
                return SizedBox(
                  height: 40,
                  width: 100,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () async {
                      await value.updatePresidentPassword(
                          newpassword: newpassController.text,
                          context: context);
                    },
                    child: const Text('UPDATE'),
                  ),
                );
              },
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
