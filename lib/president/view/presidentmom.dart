import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';

import '../controller/presidenthomecontroll.dart';
import 'presidentmomreport.dart';

class PresidentMoM extends StatefulWidget {
  const PresidentMoM({super.key});

  @override
  State<PresidentMoM> createState() => _PresidentMoMState();
}

class _PresidentMoMState extends State<PresidentMoM> {
  TextEditingController date = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const PresidentMomReport(),
                        ),
                      );
                    },
                    child: const Text('View Reports')),
              ),
            ],
          ),
        ],
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("MOM RECORD"),
      ),
      body: Consumer<PresidentController>(builder: (context, val, ch) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: date,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.calendar_today),
                      labelText: "Meet Date"),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      //print(pickedDate);
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      val.setmeetDate(formattedDate);
                      setState(() {
                        date.text = formattedDate;
                      });
                    } else {}
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Divider(),
                const Text('Location'),
                const Divider(),
                TextField(
                  onChanged: (value) {
                    val.setmeetLocation(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'location',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('No.of Attendance'),
                const Divider(),
                TextField(
                  onChanged: (value) {
                    val.setmeetattendance(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Number of attendance',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Decisions'),
                const Divider(),
                TextField(
                  onChanged: (value) {
                    val.setmeetdecisions(value);
                  },
                  maxLines: 3,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Decisions made',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Summary'),
                const Divider(),
                TextField(
                  onChanged: (value) {
                    val.setmeetsummary(value);
                  },
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Meeting summary',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: 45,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: () {
                      val.savemom(context);
                    },
                    child: const Text('SAVE'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
/*  Card(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Items(value: 'feb . 21 1998', titile: 'DATE'),
                  Divider(),
                  Items(value: 'Town Hall', titile: 'VENUE'),
                  Divider(),
                  Items(value: 'feb . 21 1998', titile: 'DAte'),
                  Items(value: 'feb . 21 1998', titile: 'DAte'),
                  Items(value: 'feb . 21 1998', titile: 'DAte')
                ],
              ),
            ),
          ) */
