import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/authentication/controller/authController.dart';
import 'package:sacco_management/member/controllers/memberConfigController.dart';
import 'package:sacco_management/president/controller/presidentConfigController.dart';
import 'package:sacco_management/splashScreen.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';

import 'member/controllers/memberController.dart';
import 'member/controllers/memberloanController.dart';
import 'president/controller/presidenthomecontroll.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthController()),
        ChangeNotifierProvider(create: (context) => MemberHomeController()),
        ChangeNotifierProvider(create: (context) => MemberLoanController()),
        ChangeNotifierProvider(create: (context) => PresidentController()),
        ChangeNotifierProvider(create: (context) => MemberConfigController()),
        ChangeNotifierProvider(create: (context) => UnitControll()),
        // ChangeNotifierProvider(create: (context) => ),
        ChangeNotifierProvider(
            create: (context) => PresidentConfigController()),
        // ChangeNotifierProvider(create: (context) => UnitControll()),
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        title: 'Micro Finance',
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
