// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PInsurance extends StatelessWidget {
  PInsurance({super.key});
  TextEditingController amoutController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Insurance'),
      ),
      body: Column(
        children: [
          Expanded(
            child:
                Consumer<PresidentController>(builder: (context, value, child) {
              return FutureBuilder(
                future: value.sambhadyam(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Form(
                      key: _formkey,
                      child: Column(children: [
                        Expanded(
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            padding: const EdgeInsets.all(5),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data[0]['memberdata'][index];
                              return Card(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(data['membername']),
                                      ),
                                      const Divider(),

                                      // const Icon(Icons.currency_rupee),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.monetization_on,
                                            color: primaryColor,
                                          ),
                                          const VerticalDivider(),
                                          Expanded(
                                            child: TextField(
                                              onChanged: (va) {
                                                value.setSavingsAmount(va);
                                              },
                                              // controller: amoutController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  hintText: 'Add Amount'),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.lock_clock_rounded,
                                            color: primaryColor,
                                          ),
                                          const VerticalDivider(),
                                          Expanded(
                                            child: TextFormField(
                                              validator: (value) {
                                                if (value == '1' ||
                                                    value == '3' ||
                                                    value == '4' ||
                                                    value == '6' ||
                                                    value == '12' ||
                                                    value == '') {
                                                  return null;
                                                } else {
                                                  return 'Enter a valid period';
                                                }
                                              },
                                              onChanged: (va) {},
                                              // controller: amoutController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                  hintText: 'Set Period'),
                                            ),
                                          ),
                                          const Text('(In Months : 1,3,4,6,12)')
                                        ],
                                      ),
                                      const Divider(
                                        color: Colors.transparent,
                                      ),
                                      CupertinoButton(
                                        child: const Text("Add"),
                                        onPressed: () async {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            // print('validated');
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              );

                              /* ListTile(
                            trailing: Row(
                              children: const [
                                TextField(),
                              ],
                            ),
                            title: Text(data['membername']),
                          ); */
                            },
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // value.addsambhadyam(context);
                          },
                          child: const Text('Save Medical Aid'),
                        ),
                      ]),
                    );
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(color: primaryColor),
                    );
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
