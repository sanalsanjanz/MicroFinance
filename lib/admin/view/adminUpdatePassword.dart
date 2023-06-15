import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminupdatePassword extends StatelessWidget {
  AdminupdatePassword({super.key});
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAdminColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Consumer<AdminController>(
                builder: (context, myType, child) {
                  return TextFormField(
                    validator: (value) {
                      if (myType.password == oldPassword.text) {
                        return null;
                      } else {
                        return 'mismatching old password';
                      }
                    },
                    controller: oldPassword,
                    decoration:
                        const InputDecoration(hintText: 'enter old password'),
                  );
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value == oldPassword.text) {
                    return 'please choose a new password';
                  } else if (value!.length <= 4) {
                    return 'atleast five required';
                  } else {
                    return null;
                  }
                },
                controller: newPassword,
                decoration:
                    const InputDecoration(hintText: 'enter new password'),
              ),
              TextFormField(
                validator: (value) {
                  if (newPassword.text != confirmPassword.text) {
                    return 'password missmatch';
                  } else {
                    return null;
                  }
                },
                controller: confirmPassword,
                decoration: const InputDecoration(hintText: 'confirm password'),
              ),
              Consumer<AdminController>(
                builder: (context, myType, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await myType.updatePassword(
                            context: context, newpassword: newPassword.text);
                      }
                    },
                    child: const Text('Update'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
