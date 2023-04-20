// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresientMonthlyCollection extends StatelessWidget {
  PresientMonthlyCollection({super.key});
  TextEditingController amoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Monthly Collection'),
      ),
      body: Column(
        children: [
          Expanded(child:
              Consumer<PresidentController>(builder: (context, value, child) {
            return FutureBuilder(
              future: value.sambhadyam(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(children: [
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        // separatorBuilder: (context, index) => const Divider(),
                        padding: const EdgeInsets.all(5),
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[0]['memberdata'][index];
                          return Card(
                            child: Container(
                              padding: const EdgeInsets.all(15),
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
                                      value.setmonthlyCollectionAmount(va);
                                    },
                                    // controller: amoutController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        hintText: 'Amount'),
                                  )),
                                  CupertinoButton(
                                    child: const Text("Add"),
                                    onPressed: () async {},
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
                    SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        onPressed: () {},
                        child: const Text('SAVE'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ]);
                } else {
                  return Center(
                      child: SpinKitFadingCircle(color: primaryColor));
                }
              },
            );
          }))
        ],
      ),
    );
  }
}
