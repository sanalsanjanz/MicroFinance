// ignore_for_file: file_names

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/unit/controllers/unitController.dart';
import 'package:sacco_management/widgets/itemsCard.dart';

class UnitViewSessFund extends StatefulWidget {
  const UnitViewSessFund({super.key});

  @override
  State<UnitViewSessFund> createState() => _UnitViewSessFundState();
}

class _UnitViewSessFundState extends State<UnitViewSessFund> {
  TextEditingController date2 = TextEditingController();
  String shgpassbookno = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sess Fund'),
        backgroundColor: primaryUnitColor,
      ),
      body: Consumer<UnitControll>(builder: (context, val, child) {
        return FutureBuilder(
          future: val.unitViewSessFund(context: context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != []) {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data[0]['sessdata'].length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data[0]['sessdata'][index];
                    return Card(
                        child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Items(
                              value: data['sessfund_date'],
                              titile: 'SESS DATE'),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Items(value: data['amount'], titile: 'SESS AMOUNT'),
                          const Divider(color: Colors.transparent),
                          Items(value: data['period'], titile: 'SESS PERIOD'),
                          const Divider(color: Colors.transparent),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: shadeUnitColor,
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () async {
                              Provider.of<UnitControll>(context, listen: false)
                                          .shglist ==
                                      []
                                  ? Provider.of<UnitControll>(context,
                                          listen: false)
                                      .getallSHG(context: context)
                                  : '';
                              showBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                  decoration:
                                      BoxDecoration(color: Colors.grey[100]),
                                  padding: const EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: 60,
                                          color: primaryUnitColor,
                                          child: const Center(
                                            child: Text(
                                              'TRANSFER',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                        Items(
                                            value: data['sessfund_date'],
                                            titile: 'SESS DATE'),
                                        const Divider(
                                          color: Colors.transparent,
                                        ),
                                        Items(
                                            value: data['amount'],
                                            titile: 'SESS AMOUNT'),
                                        const Divider(
                                            color: Colors.transparent),
                                        Items(
                                            value: data['period'],
                                            titile: 'SESS PERIOD'),
                                        const Divider(
                                            color: Colors.transparent),
                                        Container(
                                          padding: const EdgeInsets.all(15),
                                          // height: MediaQuery.of(context).size.width / 3,
                                          child: TextField(
                                            controller: date2,
                                            decoration: const InputDecoration(
                                                icon: Image(
                                                  height: 40,
                                                  image: AssetImage(
                                                      'assets/calendar.png'),
                                                ),
                                                labelText: "Choose Date"),
                                            readOnly: true,
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime(2100));
                                              if (pickedDate != null) {
                                                //print(pickedDate);
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                //print(formattedDate);
                                                setState(() {
                                                  date2.text = formattedDate;
                                                });
                                              } else {}
                                            },
                                          ),
                                        ),
                                        const Divider(
                                            color: Colors.transparent),
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: Text('Select SHG'),
                                            ),
                                            Expanded(
                                              child: DropDownTextField(
                                                dropDownList: val.shglist,
                                                onChanged: (value) {
                                                  setState(() {
                                                    shgpassbookno = value.value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                            color: Colors.transparent),
                                        ElevatedButton(
                                            onPressed: () async {
                                              await val.unitTransferSesstoShg(
                                                context: context,
                                                period: data['period'],
                                                transferdate:
                                                    data['trans_date'],
                                                sessid: data['c_sessid'],
                                                amount: data['amount'],
                                                sessfunddate:
                                                    data['sessfund_date'],
                                                shgpassbookno: shgpassbookno,
                                              );
                                            },
                                            child: const Text('Transfer'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: const Text('Transfer to SHG'),
                          ),
                        ],
                      ),
                    )

                        /* ListTile(
                        trailing: const Icon(Icons.arrow_forward_ios),
                        subtitle: const Text('Tap to select'),
                        leading: const CircleAvatar(
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.group,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(data['shgname']),
                      ), */
                        );
                  },
                );
              } else {
                return Center(child: Lottie.asset('assets/notfound.json'));
              }
            } else {
              return Center(
                child: SpinKitFadingCircle(color: primaryColor),
              );
            }
          },
        );
      }),
    );
  }
}
