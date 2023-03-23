// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresiderntFestivalFund extends StatelessWidget {
  PresiderntFestivalFund({super.key});
  TextEditingController amoutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: const Text('Festval Fund'),
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
                                        // value.setSavingsAmount(va);
                                      },
                                      // controller: amoutController,
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                          /*  border: OutlineInputBorder(
                                            borderSide: BorderSide.none), */
                                          hintText: 'Enter Amount'),
                                    ),
                                  ),
                                  const VerticalDivider(
                                    color: Colors.transparent,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor),
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
                        },
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () async {
                        await value.addfestivalfund(context);
                      },
                      child: const Text('SAVE FESTIVAL FUND'),
                    ),
                    const Divider(
                      color: Colors.transparent,
                    )
                  ]);
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }))
        ],
      ),
    );
  }
}
