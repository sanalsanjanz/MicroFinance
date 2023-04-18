import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitPaySessFund.dart';
import 'package:sacco_management/unit/views/unitViewSessFund.dart';
import 'package:sacco_management/unit/views/unitshgSessTranfertoRegion.dart';

class UnitSessFund extends StatelessWidget {
  const UnitSessFund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const UnitViewSessFund(),
                      ),
                    );
                  },
                  child: const Text('View Sess Fund'),
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const UnitPaySessFund(),
                      ),
                    );
                  },
                  child: const Text('Pay Sess Fund'),
                ),
              ),
            ],
          ),
        ],
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
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => UnitShgSessTransferToRegion(
                                shgPassbookno: data['passbookno'],
                              ),
                            ),
                          );
                        },
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Tap to select'),
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
                return Center(child: Lottie.asset('assets/notfound.json'));
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
