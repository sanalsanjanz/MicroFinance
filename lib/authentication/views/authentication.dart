import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sacco_management/authentication/controller/authController.dart';
import 'package:sacco_management/authentication/views/changePassword.dart';
import 'package:sacco_management/widgets/choiceChip.dart';

class Authetication extends StatefulWidget {
  const Authetication({super.key});

  @override
  State<Authetication> createState() => _AutheticationState();
}

class _AutheticationState extends State<Authetication> {
  @override
  void initState() {
    super.initState();
    Provider.of<AuthController>(context, listen: false).unitList.isEmpty
        ? Provider.of<AuthController>(context, listen: false).getunitsDropdown()
        : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Image(
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              image: const AssetImage('assets/graphi.jpg'),
            ),
          ),
          const Divider(),
          Expanded(
            child: Consumer<AuthController>(builder: (context, value, child) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.blueGrey[50],
                ),
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What is your role ?',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          CustomChoiceChip(
                            label: 'Group',
                            isSelected: value.shg,
                            onSelected: (values) {
                              value.chooseShg();
                            },
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .06,
                          ),
                          CustomChoiceChip(
                            label: 'Member',
                            isSelected: value.member,
                            onSelected: (values) {
                              value.chooseMember();
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          CustomChoiceChip(
                            label: 'Unit',
                            isSelected: value.unit,
                            onSelected: (values) {
                              value.setexisting();
                              value.chooseUnit();
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        value.unit
                            ? 'Fill the login form'
                            : 'Are you an existing user ?',
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      Visibility(
                        visible: !value.unit,
                        child: const SizedBox(
                          height: 20,
                        ),
                      ),
                      Visibility(
                        visible: !value.unit,
                        child: Row(
                          children: [
                            CustomChoiceChip(
                              label: 'Yes',
                              isSelected: value.existingUser,
                              onSelected: (values) {
                                value.setexisting();
                              },
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .06,
                            ),
                            CustomChoiceChip(
                              label: 'No',
                              isSelected: value.newuser,
                              onSelected: (values) {
                                value.setnewUser();
                              },
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: value.shg && value.newuser,
                        child: const Text(
                          'Choose Unit',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: value.shg && value.newuser,
                        child: DropDownTextField(
                          enableSearch: true,
                          dropDownList: value.unitList,
                          onChanged: (va) {
                            value.setunitname(va.name);
                            value.setunitid(va.value);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: value.newuser,
                        child: TextFormField(
                          onChanged: (values) => value.setsuername(values),
                          decoration:
                              const InputDecoration(hintText: 'Group Name'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: value.shg && value.newuser,
                        child: TextFormField(
                          onChanged: (values) => value.setPlace(values),
                          decoration: const InputDecoration(hintText: 'Place'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (values) => value.setphonenumber(values),
                        decoration:
                            const InputDecoration(hintText: 'Phone number'),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onChanged: (values) => value.setPassword(values),
                        obscuringCharacter: '*',
                        obscureText: value.obsurePass,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(
                            splashRadius: .1,
                            icon: Icon(
                              value.obsurePass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              value.viewPass();
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: value.newuser,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                checkColor: Colors.blue,
                                /*   shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)), */
                                value: value.agree,
                                onChanged: (val) {
                                  value.setagree(val);
                                }),
                            const Text('Agree Terms and conditions'),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: value.existingUser,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Text("Don't remember password ?  "),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) =>
                                          const ChangeMemberPassword(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "change password",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible:
                                (value.member || value.shg || value.unit) &&
                                        (value.newuser || value.existingUser) &&
                                        value.agree
                                    ? true
                                    : false,
                            child: value.newuser
                                ? SizedBox(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blueGrey,
                                        shape: const StadiumBorder(),
                                      ),
                                      onPressed: () {
                                        value.shg
                                            ? value.signuppresident(
                                                context: context)
                                            : value.signupMember(context);
                                      },
                                      child: const Text('Signup'),
                                    ),
                                  )
                                : SizedBox(
                                    height: 45,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blueGrey,
                                          shape: const StadiumBorder()),
                                      onPressed: () {
                                        value.member
                                            ? value.login(context)
                                            : value.shg
                                                ? value.loginpresident(context)
                                                : value.signinunit(context);
                                      },
                                      child: const Text('Login'),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
