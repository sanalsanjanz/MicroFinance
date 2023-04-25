import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';

class UnitRegisterNonMember extends StatefulWidget {
  const UnitRegisterNonMember({super.key});

  @override
  State<UnitRegisterNonMember> createState() => _UnitRegisterNonMemberState();
}

class _UnitRegisterNonMemberState extends State<UnitRegisterNonMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Non Member'),
        backgroundColor: primaryUnitColor,
      ),
    );
  }
}
