import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalViewUnits extends StatelessWidget {
  const RegionalViewUnits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Units'),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
            future: val.regionalGetUnits(option: 0),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['bnkdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['bnkdata'][index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: shadedRegionColor,
                          child: const Icon(
                            Icons.home,
                            color: Colors.black45,
                          ),
                        ),
                        title: Text(
                          data['unit'].toString().toUpperCase(),
                        ),
                        subtitle: const Text('Unit Name'),
                      ),
                    );
                  },
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKitFadingCircle(
                    color: primaryColor,
                  ),
                );
              } else {
                return Center(
                  child: SpinKitFadingCircle(
                    color: primaryColor,
                  ),
                );
              }
            });
      }),
    );
  }
}
