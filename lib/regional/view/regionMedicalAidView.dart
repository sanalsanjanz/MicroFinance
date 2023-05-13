import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionalAddIndividualMedicalAid.dart';

class RegionalMedicalAidView extends StatelessWidget {
  const RegionalMedicalAidView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('View Medical Aid'),
          backgroundColor: primaryRegionColor,
        ),
        body: Column(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const AddIndividualMedicalAid(),
                  ),
                );
              },
              child: const Text('Individual Medical Aid'),
            ),
            Expanded(
              child:
                  Consumer<RegionalController>(builder: (context, val, child) {
                return FutureBuilder(
                    future: val.viewMedicalAid(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return const Center(
                            child: Text('No Data'),
                          );
                        } else {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data[0]['sdata'].length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data[0]['sdata'][index];
                              return Card(
                                child: ListTile(
                                  onTap: () async {
                                    await val.transferMedicalAid(
                                      context: context,
                                      mid: data['mid'],
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: shadedRegionColor,
                                    child: const Icon(
                                      Icons.data_saver_off_rounded,
                                      color: Colors.black45,
                                    ),
                                  ),
                                  trailing: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(data['amount']),
                                      Text(data['pdate']),
                                    ],
                                  ),
                                  title: Text(data['unitname']),
                                  subtitle: const Text('tap to tranfer'),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(child: Text('No Data'));
                      }
                    });
              }),
            ),
          ],
        ));
  }
}
