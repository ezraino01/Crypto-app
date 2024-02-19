import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:ezraino/CustomizeTexT.dart';
import 'package:ezraino/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Main Page1.dart';
import 'Registeration Page.dart';

class Login extends StatefulWidget {
  final User? user;
  const Login({
    super.key,
    this.user,
  });

  @override
  State<Login> createState() => _loginState();
}

class _loginState extends State<Login> {
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  bool isSwitch = false;
  bool isToggled = false;
  bool circularProgressIndicator = false;
  final _Formkey = GlobalKey<FormState>();
  SignUpUser signUpUser = SignUpUser();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _Formkey,
            child: Column(
              children: [
                Text('Login',
                    style:
                        TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
                Textfund(
                  controller: Emailcontroller,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'cant be empty';
                    }
                    return null;
                  },
                  hintText: 'enter email',
                  labelText: 'email',
                ),
                SizedBox(
                  height: 10,
                ),
                Textfund(
                  controller: Passwordcontroller,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'cant be empty';
                    }
                    return null;
                  },
                  hintText: 'enter password',
                  labelText: 'password',
                  suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          if (isToggled == true) {
                            isToggled = false;
                          } else {
                            isToggled = true;
                          }
                        });
                      },
                      child: isToggled
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  obscureText: isToggled,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forget your password?'),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0XfffDB3022),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    minWidth: double.infinity,
                    height: height * 0.07,
                    onPressed: () {
                      if (_Formkey.currentState!.validate()) {
                        setState(() {
                          circularProgressIndicator = true;
                        });
                        signUpUser
                            .loginWithEmailandPassword(
                              email: Emailcontroller.text,
                              password: Passwordcontroller.text,
                            )
                            .then((list) => {
                                  if (list.first==true)
                                    {
                                      signUpUser.getUsers(uid: signUpUser.user!.uid)
                                          .then((myUser) => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MainPAGE(
                                                              user: myUser,
                                                            )),
                                                ),
                                              }),
                                      Fluttertoast.showToast(msg: list.last),
                                      setState(() {
                                        circularProgressIndicator = false;
                                        print('................................hello world');
                                      })
                                    }
                                  else
                                    {
                                      setState(() {
                                        circularProgressIndicator = false;
                                      }),
                                      Fluttertoast.showToast(msg: list.last)
                                    }
                                  // print(list.last)
                                });
                      }
                    },
                    color: Color(0XfffDB3022),
                    child: circularProgressIndicator
                        ? CircularProgressIndicator()
                        : Text(
                            'login',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                      width: width * 0.45,
                      color: Colors.red,
                    ),
                    Text(
                      'or',
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 1,
                      width: width * 0.45,
                      color: Colors.red,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'Continue with Google',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            alignment: Alignment.topLeft,
                            image: AssetImage('assets/images/img_2.png'))),
                    height: height * 0.08,
                    width: double.infinity,
                  ),
                  focusColor: Colors.red,
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'Continue with Apple',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        image: DecorationImage(
                            alignment: Alignment.bottomLeft,
                            image: AssetImage('assets/images/img_1.png'))),
                    height: height * 0.08,
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Investment()));
                  },
                  child: Text(
                    'Create a ZrainoTech Account',
                    style: TextStyle(color: Color(0xfffdb3022), fontSize: 16),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
