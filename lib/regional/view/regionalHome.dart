import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/regional/view/regionMessaageView.dart';
import 'package:sacco_management/regional/view/regionalViewGrant.dart';

class RegionalHome extends StatefulWidget {
  const RegionalHome({super.key});

  @override
  State<RegionalHome> createState() => _RegionalHomeState();
}

class _RegionalHomeState extends State<RegionalHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false).getsaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
                child: Container(
              color: primaryRegionColor,
            ))
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const RegionalMessagesView(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.message),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                // right: 5,
                // top: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 10,
                  child: Consumer<RegionalController>(
                    builder: (context, myType, child) {
                      return Text(myType.messagecount);
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            width: 8,
          )
          // const VerticalDivider(),
        ],
        title: const Text('Regional'),
        // centerTitle: true,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: primaryRegionColor),
        backgroundColor: primaryRegionColor,
      ),
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return Column(
          children: [
            Card(
              color: const Color.fromARGB(64, 8, 130, 149),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    const VerticalDivider(),
                    Text(
                      val.regionalName,
                      style: title,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctc) => const RegionalViewGrant(),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2,
                        // elevation: 5,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Image(
                                color: Colors.black,
                                image: AssetImage('assets/bank.png'),
                                height: 80,
                              ),
                              const Divider(),
                              Text(
                                'GRANT',
                                style: titleblack,
                              ),
                              const Spacer(),
                              const Text(
                                'View grant details',
                                style: TextStyle(
                                    color: Colors.black87, letterSpacing: 2),
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
