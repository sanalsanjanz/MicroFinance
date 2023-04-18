// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitTrackSavings.dart';

class UnitUnitSavings extends StatelessWidget {
  const UnitUnitSavings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getallSHG(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['sdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sdata'][index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitTrackSavings(
                                passno: data['passbookno'],
                              ),
                            ),
                          );
                        },
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Track Savings'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['shgname']),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('No SHG Found'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      }),
    );
  }
}
