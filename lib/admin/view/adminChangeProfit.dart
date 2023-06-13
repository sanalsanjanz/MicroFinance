import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/admin/controller/adminController.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminChangeProfit extends StatefulWidget {
  AdminChangeProfit(
      {super.key, required this.passbookno, required this.regname});
  String passbookno;
  String regname;
  @override
  State<AdminChangeProfit> createState() => _AdminChangeProfitState();
}

class _AdminChangeProfitState extends State<AdminChangeProfit> {
  @override
  void initState() {
    super.initState();
    Provider.of<AdminController>(context, listen: false)
        .getProfit(regionpassbookno: widget.passbookno);
  }

  final TextEditingController _profit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryAdminColor,
        title: const Text('Change Profit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Divider(color: Colors.transparent),
            Center(
              child: Text(
                widget.regname.toUpperCase(),
                style: titleblack,
              ),
            ),
            const Divider(),
            const Divider(color: Colors.transparent),
            Consumer<AdminController>(
              builder: (context, myType, child) {
                return TextFormField(
                  onChanged: (value) {
                    setState(() {
                      myType.profit = value;
                    });
                  },
                  initialValue: myType.profit,
                  decoration: const InputDecoration(
                      helperText: 'Edit Porofit', border: OutlineInputBorder()),
                );
              },
            ),
            const Divider(
              color: Colors.transparent,
            ),
            Consumer<AdminController>(
              builder: (context, myType, child) {
                return ElevatedButton(
                  onPressed: () async {
                    await myType.updateProfit(
                        context: context,
                        profits: myType.profit,
                        regionpassbookno: widget.passbookno);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: shadeAdminColor),
                  child: const Text('Update Profit'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
