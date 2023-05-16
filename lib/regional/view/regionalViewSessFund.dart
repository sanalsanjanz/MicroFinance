import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/regional/controller/regionalController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class RegionalViewSessFund extends StatefulWidget {
  const RegionalViewSessFund({super.key});

  @override
  State<RegionalViewSessFund> createState() => _RegionalViewSessFundState();
}

class _RegionalViewSessFundState extends State<RegionalViewSessFund> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final TextEditingController dateInput1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<RegionalController>(context, listen: false)
            .regionalUnitList
            .isEmpty
        ? Provider.of<RegionalController>(context, listen: false)
            .regionalGetUnits()
        : '';
  }

  var unitPassbookno = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RegionalController>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.regionalViewSess(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(5),
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data[0]['sessdata'].length,
                itemBuilder: (context, index) {
                  var data = snapshot.data[0]['sessdata'][index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const Divider(color: Colors.transparent),
                          Items(value: data['cdate'], titile: 'Sess Date'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['amount'], titile: 'Sess Amount'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['period'], titile: 'Sess Period'),
                          const Divider(color: Colors.transparent),
                          const Divider(color: Colors.black45),
                          SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: shadeprimaryColor),
                              onPressed: () async {
                                showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Card(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              height: 50,
                                              color: shadedRegionColor,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('TRANSFER'),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon:
                                                        const Icon(Icons.close),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const Divider(),
                                            DropDownTextField(
                                              onChanged: (value) {
                                                setState(() {
                                                  unitPassbookno = value.value;
                                                });
                                              },
                                              dropDownList:
                                                  val.regionalUnitList,
                                            ),
                                            const Divider(
                                                color: Colors.transparent),
                                            Items(
                                                value: data['cdate'],
                                                titile: 'Sess Date'),
                                            const Divider(
                                                color: Colors.transparent),
                                            Items(
                                                value: data['amount'],
                                                titile: 'Sess Amount'),
                                            const Divider(
                                                color: Colors.transparent),
                                            Items(
                                                value: data['period'],
                                                titile: 'Sess Period'),
                                            const Divider(
                                                color: Colors.transparent),
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              // height: MediaQuery.of(context).size.width / 3,ss
                                              child: TextField(
                                                controller: dateInput1,
                                                decoration:
                                                    const InputDecoration(
                                                        icon: Icon(Icons
                                                            .calendar_today),
                                                        labelText:
                                                            "Transfer Date"),
                                                readOnly: true,
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime.now());

                                                  if (pickedDate != null) {
                                                    //print(pickedDate);
                                                    String formattedDate =
                                                        DateFormat('yyyy-MM-dd')
                                                            .format(pickedDate);

                                                    setState(() {
                                                      dateInput1.text =
                                                          formattedDate;
                                                    });
                                                  } else {}
                                                },
                                              ),
                                            ),
                                            const Divider(
                                                color: Colors.transparent),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        primaryRegionColor),
                                                onPressed: () async {
                                                  await val
                                                      .regionalTransferSessFundToUnit(
                                                          context: context,
                                                          sessid: data['id'],
                                                          csdate: data['cdate'],
                                                          period:
                                                              data['period'],
                                                          amount:
                                                              data['amount'],
                                                          stdate:
                                                              dateInput1.text,
                                                          unitpassbookno:
                                                              unitPassbookno);
                                                },
                                                child: const Text('Tranfer'))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                /*  await val.regionalTransferSessFund(
                                  context: context,
                                  mid: data['mid'],
                                ); */
                              },
                              child: const Text('Transfer to Unit'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SpinKitFadingCircle(
                color: primaryColor,
              ));
            } else {
              return Center(
                  child: SpinKitFadingCircle(
                color: primaryColor,
              ));
            }
          },
        );
      }),
    );
  }
}
