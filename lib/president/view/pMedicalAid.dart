// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PMedicalAid extends StatelessWidget {
  PMedicalAid({super.key});
  TextEditingController amoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Medical Aid'),
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
                    return Column(children: [
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          padding: const EdgeInsets.all(5),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var data = snapshot.data[0]['memberdata'][index];
                            return Card(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(data['membername']),
                                      ),
                                    ),
                                    const Text(':    '),
                                    // const Icon(Icons.currency_rupee),
                                    Expanded(
                                        child: TextField(
                                      onChanged: (va) {
                                        value.setSavingsAmount(va);
                                      },
                                      // controller: amoutController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          hintText: 'Add Amount'),
                                    )),
                                    CupertinoButton(
                                      child: const Text("Add"),
                                      onPressed: () async {
                                        await value
                                            .demoaddSavings(data['memberid']);
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
                    ]);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
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
