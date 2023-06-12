import 'package:flutter/material.dart';
import 'package:sacco_management/constants/styles.dart';

class AdminIndividualMessage extends StatelessWidget {
  const AdminIndividualMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Messages'),
        backgroundColor: primaryAdminColor,
      ),
      body: Column(
        children: [
          const TextField(
            decoration: InputDecoration(hintText: 'type message'),
            maxLines: 5,
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }
}
