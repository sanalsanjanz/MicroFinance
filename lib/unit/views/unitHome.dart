import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/unit/views/unitExpense.dart';
import 'package:sacco_management/unit/views/unitIncome.dart';
import 'package:sacco_management/unit/views/unitMessages.dart';
import 'package:sacco_management/widgets/unitHomeCard.dart';

class UnitHome extends StatefulWidget {
  const UnitHome({super.key});

  @override
  State<UnitHome> createState() => _UnitHomeState();
}

class _UnitHomeState extends State<UnitHome> {
  @override
  void initState() {
    super.initState();
    Provider.of<UnitControll>(context, listen: false).getdatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Consumer<UnitControll>(builder: (context, value, child) {
          return ListView(
            children: [
              DrawerHeader(
                padding: const EdgeInsets.all(0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  // height: 100,
                  color: primaryUnitColor,
                  child: Row(children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/users.png'),
                    ),
                    const VerticalDivider(),
                    Text(value.unitName.toString())
                  ]),
                ),
              ),
              const Card(child: ListTile())
            ],
          );
        }),
      ),
      appBar: AppBar(
        title: const Text('Unit'),
        actions: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const UnitChats(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.message,
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  // alignment: Alignment.topLeft,
                  child: Consumer<UnitControll>(builder: (context, val, child) {
                    return Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Text(val.messageCount.toString()),
                    );
                  }))
            ],
          ),
          PopupMenuButton(
            itemBuilder: (context) =>
                [const PopupMenuItem(child: Text('Update Password'))],
          ),
        ],
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: primaryUnitColor),
        backgroundColor: primaryUnitColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                // height: 100,
                width: double.maxFinite,
                child: Row(
                  children: [
                    const CircleAvatar(
                      // backgroundColor: shadeUnitColor,
                      child: Icon(Icons.account_balance_rounded),
                    ),
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    const Text(
                      'UNIT NAME :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const VerticalDivider(
                      color: Colors.transparent,
                    ),
                    Consumer<UnitControll>(builder: (context, val, ch) {
                      return Text(
                        val.unitName.toString().toUpperCase(),
                        style: TextStyle(
                            color: primaryUnitColor,
                            fontWeight: FontWeight.bold),
                      );
                    }),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              /*  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitIncome(),
                                ),
                              ); */
                            },
                            title: 'GRANT',
                            description: 'Check your Grant activities',
                            icon: 'assets/grantshow.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              /*  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitExpense(),
                                ),
                              ); */
                            },
                            title: 'BANK LINKAGE',
                            description: 'Check your Bank activities',
                            icon: 'assets/bank.png')
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              /*  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitIncome(),
                                ),
                              ); */
                            },
                            title: 'MEDICAL AID',
                            description: 'Check your Medical Aid activities',
                            icon: 'assets/medicalaid.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              /*  Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitExpense(),
                                ),
                              ); */
                            },
                            title: 'SESS FUND',
                            description: 'Check your Sess activities',
                            icon: 'assets/pay.png')
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitIncome(),
                                ),
                              );
                            },
                            title: 'INCOME',
                            description: 'Check your income activities',
                            icon: 'assets/income.png'),
                        const VerticalDivider(
                          width: 5,
                        ),
                        UnitHomeCard(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => const UnitExpense(),
                                ),
                              );
                            },
                            title: 'EXPENSE',
                            description: 'Check your Expense activities',
                            icon: 'assets/expenseicon.png')
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
