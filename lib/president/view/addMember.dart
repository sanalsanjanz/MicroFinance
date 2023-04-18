// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/constants/styles.dart';
import 'package:sacco_management/president/controller/presidenthomecontroll.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isMemberList = true;
  bool isaddmember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Add Member'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMemberList = true;
                        isaddmember = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor:
                            isMemberList ? Colors.green[300] : primaryColor),
                    child: const Text('Members'),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isMemberList = false;
                        isaddmember = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor:
                            isaddmember ? Colors.green[300] : primaryColor),
                    child: const Text('Add Member'),
                  ),
                ),
                const VerticalDivider(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isMemberList && !isaddmember
                          ? Colors.green[300]
                          : primaryColor,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {
                      setState(() {
                        isMemberList = false;
                        isaddmember = false;
                      });
                    },
                    child: const Text('Requests'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Consumer<PresidentController>(
                  builder: (context, value, child) {
                return isaddmember
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          const Text('Enter Memeber Details'),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: emailController,
                            decoration:
                                const InputDecoration(hintText: 'Name/Email'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: numberController,
                            decoration:
                                const InputDecoration(hintText: 'Phone number'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: passwordController,
                            decoration: const InputDecoration(
                                helperText:
                                    'member can change the password later !!',
                                hintText: 'Give a password'),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor),
                            onPressed: () {
                              value.addmember(context,
                                  password: passwordController.text,
                                  number: numberController.text,
                                  mailid: emailController.text);
                            },
                            child: const Text("Add Member"),
                          ),
                        ],
                      )
                    : FutureBuilder(
                        future: isMemberList
                            ? value.memberlist()
                            : value.getMemberRequets(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                // padding: const EdgeInsets.all(10),
                                separatorBuilder: (context, index) =>
                                    const Divider(),
                                itemCount:
                                    snapshot.data[0]['memberdata'].length,
                                itemBuilder: (context, index) {
                                  var data =
                                      snapshot.data[0]['memberdata'][index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: shadeprimaryColor,
                                      child: const Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Text(data['membername']),
                                    trailing: isMemberList
                                        ? value.name == data['membername']
                                            ? const Text('President')
                                            : IconButton(
                                                onPressed: () {
                                                  showBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          color:
                                                              Colors.amber[100],
                                                          width:
                                                              double.maxFinite,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                  "Do you want to remove ${data['membername']} from your group ?"),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                            'No'),
                                                                  ),
                                                                  const VerticalDivider(),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () async {
                                                                      await value.deletemember(
                                                                          data[
                                                                              'memberid'],
                                                                          context,
                                                                          data[
                                                                              'membername']);
                                                                    },
                                                                    child: const Text(
                                                                        'Yes'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                  color: Color.fromARGB(
                                                      255, 246, 181, 176),
                                                ))
                                        : IconButton(
                                            onPressed: () async {
                                              await value.acceptMemberRequest(
                                                  data['memberid'],
                                                  context,
                                                  data['membername']);
                                            },
                                            icon: const Icon(Icons.person_add)),
                                  );
                                });
                          } else {
                            return Center(
                                child: Lottie.asset('assets/notfound.json'));
                          }
                        },
                      );
              }),
            )
          ],
        ),
      ),
    );
  }
}
