import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresidentChat extends StatefulWidget {
  const PresidentChat({super.key});

  @override
  State<PresidentChat> createState() => _PresidentChatState();
}

class _PresidentChatState extends State<PresidentChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: primaryColor,
      ),
      body: Consumer<PresidentController>(builder: (context, val, child) {
        return FutureBuilder(
            future: val.getDataa(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[2]['messagedata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[2]['messagedata'][index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: shadeprimaryColor,
                        child: const Icon(
                          Icons.chat_rounded,
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
