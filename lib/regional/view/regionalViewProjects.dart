import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sacco_management/regional/view/regionalViewProjectDetails.dart';

class RegionalViewProject extends StatelessWidget {
  const RegionalViewProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.viewProjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data[0]['projectdata'].length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[0]['projectdata'][index];
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => RegionalViewProjectDetails(
                              agency: data['funding_agency'],
                              area: data['area'],
                              duration: data['duration'],
                              estimate: data['estimate'],
                              projectName: data["pjt_name"],
                              purpose: data['purpose'],
                              date: data['c_date'],
                              projectId: data['pjt_id'],
                            ),
                          ),
                        );
                      },
                      leading: CircleAvatar(
                          backgroundColor: shadedRegionColor,
                          child: Text((index + 1).toString())),
                      title: Text(data['pjt_name']),
                      subtitle: const Text('View details'),
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
