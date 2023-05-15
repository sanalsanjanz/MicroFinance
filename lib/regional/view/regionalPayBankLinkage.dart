import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalPayBankLinkage extends StatelessWidget {
  const RegionalPayBankLinkage({super.key});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return Scaffold(
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.viewBankLinkage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(5),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data[0]['bnkdata'].length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[0]['bnkdata'][index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Items(
                              value: formatter.format(DateTime.now()),
                              titile: 'Payment Date'),
                          const Divider(color: Colors.transparent),
                          Items(
                              value: data['ldate'],
                              titile: 'Bank Linkage Date'),
                          const Divider(color: Colors.transparent),
                          Items(
                              value: data['amount'],
                              titile: 'Bank Linkage Amount'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['bal'], titile: 'Balance Amount'),
                          const Divider(color: Colors.transparent),
                          const Divider(color: Colors.black45),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: shadedRegionColor),
                              onPressed: () async {
                                await val.payBankLinkage(
                                    context: context,
                                    loanid: data['id'],
                                    date: formatter.format(DateTime.now()));
                              },
                              child: const Text('Pay'),
                            ),
                          ),
                        ],
                      ),
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
          },
        );
      }),
    );
  }
}
