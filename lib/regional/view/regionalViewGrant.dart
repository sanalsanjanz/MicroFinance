import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionalTransferGrant.dart';

class RegionalViewGrant extends StatelessWidget {
  const RegionalViewGrant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Grand'),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
            future: val.viewGrant(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['grantdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['grantdata'][index];
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctc) => RegionalTransferGrant(
                                grantid: data['id'],
                                grantamount: data['amount'],
                                grantdate: data['gdate'],
                                granttype: data['type'],
                              ),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: shadedRegionColor,
                          child: const Icon(
                            Icons.edit_document,
                            color: Colors.black45,
                          ),
                        ),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.currency_rupee),
                            Text(data['amount'])
                          ],
                        ),
                        title: Text(data['type']),
                        subtitle: const Text('Tap to view details'),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: SpinKitFadingCircle(
                  color: primaryColor,
                ));
              } else {
                return Center(
                    child: SpinKitFadingCircle(
                  color: primaryColor,
                ));
              }
            });
      }),
    );
  }
}
