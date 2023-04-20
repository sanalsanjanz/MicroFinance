// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

class UnitChats extends StatefulWidget {
  const UnitChats({super.key});

  @override
  State<UnitChats> createState() => _UnitChatsState();
}

class _UnitChatsState extends State<UnitChats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
            future: val.getDataa(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[2]['messagedata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[2]['messagedata'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: shadeUnitColor,
                        child: const Icon(
                          Icons.messenger_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(data['admin_type']),
                      subtitle: Text(data['message']),
                    );
                  },
                );
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
