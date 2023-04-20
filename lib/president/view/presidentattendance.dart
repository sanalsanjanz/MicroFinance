import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class PresidentAttendance extends StatefulWidget {
  const PresidentAttendance({super.key});

  @override
  State<PresidentAttendance> createState() => _PresidentAttendanceState();
}

class _PresidentAttendanceState extends State<PresidentAttendance> {
  @override
  void initState() {
    super.initState();
    Provider.of<PresidentController>(context, listen: false).attend.isEmpty
        ? Provider.of<PresidentController>(context, listen: false).initsattend()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        backgroundColor: primaryColor,
        // toolbarHeight: 10,
      ),
      body: Consumer<PresidentController>(builder: (context, val, chi) {
        return Column(
          children: [
            Card(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        val.formatted,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                      const Divider(),
                      const Text('TODAY')
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: val.attendance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data[0]['memberdata'].length,
                      itemBuilder: (context, index) {
                        var data = snapshot.data[0]['memberdata'][index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              color: primaryColor,
                            ),
                          ),
                          trailing: Checkbox(
                            checkColor: Colors.white,
                            //fillColor: MaterialStateProperty.resolveWith(),
                            value:
                                val.attend.isEmpty ? false : val.attend[index],
                            shape: const CircleBorder(),
                            onChanged: (bool? value) {
                              val.checkattenance(index, value);
                              val.markattendance(id: data['memberid']);
                            },
                          ),
                          title: Text(data['membername']),
                          subtitle: Text(data['memberid']),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: SpinKitFadingCircle(color: primaryColor),
                    );
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () async {
                  await val.attendancelist(context);
                },
                child: const Text('SAVE'),
              ),
            ),
            const SizedBox(height: 15)
          ],
        );
      }),
    );
  }
}
