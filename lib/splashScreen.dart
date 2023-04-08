// ignore_for_file: file_names, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:sacco_management/authentication/views/authentication.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/member/views/memberHome.dart';
import 'package:sacco_management/president/view/presidenthome.dart';
import 'package:sacco_management/unit/views/unitHome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      getLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        color: primaryColor,
        child: Center(
          child: Lottie.asset('assets/splash.json', height: 150),
        ),
      ),
    );
  }

  void getLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var user = preferences.getString('login');
    if (user == 'member') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const MemberHome()),
          (route) => false);
    } else if (user == 'group') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const PresidentHome()),
          (route) => false);
    } else if (user == 'unit') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const UnitHome()),
          (route) => false);
    } else if (user == 'reginal') {
    } else if (user == 'head') {
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const Authetication()),
          (route) => false);
    }
  }
}
