import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controllers/memberController.dart';

class SearchGroup extends StatelessWidget {
  const SearchGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          children: [
            Consumer<MemberHomeController>(builder: (context, values, child) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  onChanged: (value) => values.setKeyword(value),
                  decoration: InputDecoration(
                      icon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.search),
                      ),
                      hintText: 'Enter group name',
                      filled: true,
                      fillColor: Colors.green[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      )),
                ),
              );
            }),
            /*  Consumer<MemberHomeController>(builder: (context, value, child) {
              return CupertinoButton(
                  child: const Text('Search'),
                  onPressed: () {
                    value.searchUnit();
                  });
            }), */
            Expanded(child: Consumer<MemberHomeController>(
                builder: (context, value, child) {
              return FutureBuilder(
                future: value.searchUnit(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data[0]['message'] != 'Empty') {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        // separatorBuilder: (context, index) => const Divider(),
                        itemCount: snapshot.data[0]['logdata'].length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[0]['logdata'][index];
                          return Card(
                            child: ListTile(
                              trailing: IconButton(
                                  onPressed: () {
                                    value.sendRequest(context,
                                        presid: data['presidentid']);
                                  },
                                  icon: const Icon(Icons.person_add_alt_1)),
                              leading: const CircleAvatar(
                                radius: 22,
                                backgroundColor: Colors.transparent,
                                child: Image(
                                    image:
                                        AssetImage('assets/unitprofile.png')),
                                /*  backgroundImage:
                                  AssetImage('assets/unitprofile.png'), */
                              ),
                              title: Text(data['unitname']),
                              subtitle: Text(data['district']),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: SpinKitFadingCircle(color: primaryColor));
                    }
                  } else {
                    return const Center(
                      child: Text('No result'),
                    );
                  }
                },
              );
            }))
          ],
        ),
      )),
    );
  }
}
