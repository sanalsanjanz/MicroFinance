import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitSessFund extends StatelessWidget {
  const UnitSessFund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sess Fund'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getallSHG(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != []) {
                return ListView.builder(
                  itemCount: snapshot.data[0]['sdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sdata'][index];
                    return Card(
                      child: ListTile(
                        title: Text(data['shgname']),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('no data found'),
                );
              }
            } else {
              return const Center(
                child: Text('Failed'),
              );
            }
          },
        );
      }),
    );
  }
}
