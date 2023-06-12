import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminIndividualMessage extends StatelessWidget {
  AdminIndividualMessage(
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
        backgroundColor: primaryAdminColor,
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
            Consumer<AdminController>(builder: (context, value, child) {
              return ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: shadeAdminColor),
                onPressed: () async {
                  type == 'SHGALL'
                      ? await value.sendToAllShg(
                          context: context, message: messageController.text)
                      : type == 'SHGIND'
                          ? await value.sendToShg(
                              context: context,
                              message: messageController.text,
                              shgpassbookno: passbookNo.toString())
                          : type == 'UNITIND'
                              ? value.sendToUnit(
                                  context: context,
                                  message: messageController.text,
                                  unitpassbookno: passbookNo.toString(),
                                )
                              : type == 'UNITALL'
                                  ? value.sendToAllUnit(
                                      context: context,
                                      message: messageController.text)
                                  : type == 'REGALL'
                                      ? value.sendToAllRegional(
                                          context: context,
                                          message: messageController.text)
                                      : type == 'REGIND'
                                          ? value.sendToRegional(
                                              context: context,
                                              message: messageController.text,
                                              regionpassbookno:
                                                  passbookNo.toString(),
                                            )
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
                                : type == 'REGIND'
                                    ? 'Send to $name'
                                    : type == 'REGALL'
                                        ? 'Send to All Regionals'
                                        : ''),
              );
            }),
          ],
        ),
      ),
    );
  }
}
