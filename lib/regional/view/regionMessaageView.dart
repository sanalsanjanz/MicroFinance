import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalMessagesView extends StatelessWidget {
  const RegionalMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.getMessages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data[1]['messagedata'].length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[1]['messagedata'][index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: shadedRegionColor,
                      child: Icon(
                        Icons.notification_important,
                        color: primaryRegionColor,
                      ),
                    ),
                    title: Text(data['message']),
                    subtitle: Text(data['admin_type']),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('waiting'),
              );
            } else {
              return const Center(
                child: Text('loading'),
              );
            }
          },
        );
        /* FutureBuilder(
            future: val.getMessages(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
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
                ) 
              } else {
                return const Center(
                    /*  child: SpinKitFadingCircle(
                  color: primaryColor,
                ) */
                    );
              }
            });*/
      }),
    );
  }
}
