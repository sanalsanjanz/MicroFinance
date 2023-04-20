// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitChatScreen.dart';

class UnitSendMessages extends StatelessWidget {
  const UnitSendMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Messages'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getallSHG(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != []) {
                return Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => UnitChatScreen(
                                        option: 2,
                                        number: '',
                                        name: '',
                                        passbook: ''),
                                  ),
                                );
                              },
                              subtitle: const Center(
                                child: Text('Broadcast message'),
                              ),
                              title:
                                  const Center(child: Text('Send to All SHG')),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data[0]['sdata'].length,
                        itemBuilder: (context, index) {
                          var data = snapshot.data[0]['sdata'][index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => UnitChatScreen(
                                        option: 1,
                                        number: data['shgid'].toString(),
                                        name: data['shgname'],
                                        passbook: data['passbookno']),
                                  ),
                                );
                              },
                              trailing: const Icon(Icons.arrow_forward_ios),
                              subtitle: const Text('Tap to chat'),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(
                                  Icons.chat_bubble,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(data['shgname']),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Lottie.asset('assets/notfound.json'),
                );
              }
            } else {
              return Center(
                child: SpinKitFadingCircle(color: primaryColor),
              );
            }
          },
        );
      }),
    );
  }
}
