import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalPaySessFund extends StatefulWidget {
  const RegionalPaySessFund({super.key});

  @override
  State<RegionalPaySessFund> createState() => _RegionalPaySessFundState();
}

class _RegionalPaySessFundState extends State<RegionalPaySessFund> {
  @override
  void initState() {
    super.initState();
    //Provider.of<RegionalController>(context, listen: false).getSessPayInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Consumer<RegionalController>(builder: (context, val, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Items(value: val.sessAmount, titile: 'Sess Amount'),
              const Divider(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryRegionColor),
                child: const Text('Transfer'),
                onPressed: () async {
                  await val.trasnferPayment(
                      context: context, amount: val.sessAmount);
                },
              ),
              Expanded(
                  child: Card(
                child: FutureBuilder(
                    future: val.getSessPayInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length == 0) {
                          return const Center(
                            child: Text('No Data'),
                          );
                        } else {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data[1]['datas'].length,
                            itemBuilder: (context, index) {
                              var data = snapshot.data[1]['datas'][index];
                              return Card(
                                child: ListTile(
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
                                      Text(data['total_paid']),
                                      const Text('Total Paid'),
                                    ],
                                  ),
                                  title: Text(data['unit_name']),
                                  subtitle: Text(data['trans_date']),
                                ),
                              );
                            },
                          );
                        }
                      } else {
                        return const Center(child: Text('No Data'));
                      }
                    }),
              ))
            ],
          );
        }),
      ),
    );
  }
}
