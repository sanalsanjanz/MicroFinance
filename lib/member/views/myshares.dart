import 'package:flutter/material.dart';

import '../../constants/styles.dart';

class MyShares extends StatelessWidget {
  const MyShares({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: memberPrimary,
        title: const Text('Shares'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('My Shares'),
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: memberPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
