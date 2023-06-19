// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';

class RegionalSendIndMessages extends StatelessWidget {
  RegionalSendIndMessages(
      {super.key, this.passbookNo, required this.type, this.name});
  String? passbookNo;
  String? name;
  String type;
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Messages'),
        backgroundColor: primaryRegionColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Divider(color: Colors.transparent),
            TextField(
              controller: messageController,
              decoration: const InputDecoration(
                  hintText: 'type message', border: OutlineInputBorder()),
              maxLines: 5,
            ),
            const Divider(color: Colors.transparent),
            Consumer<RegionalController>(builder: (context, value, child) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: shadedRegionColor),
                onPressed: () async {
                  type == 'SHGALL'
                      ? await value.sendMessageToAllShg(
                          context: context,
                          message: messageController.text,
                        )
                      : type == 'SHGIND'
                          ? await value.sendMessageToShg(
                              passbookNumber: passbookNo.toString(),
                              name: name.toString(),
                              context: context,
                              message: messageController.text,
                            )
                          : type == 'UNITIND'
                              ? value.sendMessageToUnit(
                                  context: context,
                                  message: messageController.text,
                                  passbookNumber: passbookNo.toString(),
                                  name: name.toString())
                              : type == 'UNITALL'
                                  ? value.sendMessageToAllUnit(
                                      context: context,
                                      message: messageController.text)
                                  : '';
                },
                child: Text(type == 'SHGALL'
                    ? 'Send to All SHG'
                    : type == 'SHGIND'
                        ? 'Send to $name'
                        : type == 'UNITIND'
                            ? 'Send to $name'
                            : type == 'UNITALL'
                                ? 'Send to All Units'
                                : ''),
              );
            }),
          ],
        ),
      ),
    );
  }
}
