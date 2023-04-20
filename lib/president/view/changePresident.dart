// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class ChangePresident extends StatefulWidget {
  const ChangePresident({super.key});

  @override
  State<ChangePresident> createState() => _ChangePresidentState();
}

class _ChangePresidentState extends State<ChangePresident> {
  String memberid = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Members'),
      ),
      body: Consumer<PresidentController>(builder: (context, val, chi) {
        return Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: val.attendance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data[0]['memberdata'].length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['memberdata'][index];
                        return ListTile(
                          onTap: () {
                            val.name == data['membername']
                                ? ''
                                : showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(32.0),
                                        ),
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Do you want to change your president from ${val.name} to ${data['membername']} ?',
                                            textAlign: TextAlign.center,
                                          ),
                                          const Divider(
                                            color: Colors.transparent,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('NO'),
                                              ),
                                              const VerticalDivider(),
                                              TextButton(
                                                onPressed: () async {
                                                  await val.changePresident(
                                                      context,
                                                      data['memberid']);
                                                },
                                                child: const Text('YES'),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                          },
                          trailing: Text(val.name == data['membername']
                              ? 'President'
                              : ''),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                          ),
                          title: Text(data['membername']),
                          subtitle: Text(val.name == data['membername']
                              ? ''
                              : 'Make president'),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: SpinKitFadingCircle(
                      color: primaryColor,
                    ));
                  }
                },
              ),
            ),
            const SizedBox(height: 15)
          ],
        );
      }),
    );
  }
}
