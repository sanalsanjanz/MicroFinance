// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/authController.dart';

class ChangeMemberPassword extends StatelessWidget {
  const ChangeMemberPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  image: const AssetImage('assets/graphi.jpg'),
                ),
              ),
              const Divider(),
              Expanded(
                child:
                    Consumer<AuthController>(builder: (context, value, child) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      color: Colors.blueGrey[50],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (values) => value.setphonenumber(values),
                            decoration:
                                const InputDecoration(hintText: 'Phone number'),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            onChanged: (values) => value.setPassword(values),
                            decoration: const InputDecoration(
                              hintText: 'New Password',
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 45,
                                width: MediaQuery.of(context).size.width / 2,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blueGrey,
                                      shape: const StadiumBorder()),
                                  onPressed: () {
                                    value.changememberpassword(context);
                                  },
                                  child: const Text('Change Password'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              )
            ],
          )),
    );
  }
}
