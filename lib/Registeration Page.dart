import 'dart:math';

import 'package:email_auth/email_auth.dart';
import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:ezraino/CustomizeTexT.dart';
import 'package:ezraino/Login%20Page.dart';
import 'package:ezraino/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Investment extends StatefulWidget {
  const Investment({super.key});

  @override
  State<Investment> createState() => _InvestmentState();
}

class _InvestmentState extends State<Investment> {
  TextEditingController Namecontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController Passwordcontroller = TextEditingController();
  TextEditingController Confirmcontroller = TextEditingController();
  TextEditingController Usercontroller = TextEditingController();
  TextEditingController OTPcontroller = TextEditingController();

  bool isToggled = false;
  bool isToggle = false;
  bool greenIcon = false;
  bool isSwitch = false;
  bool circularProgressIndicator = false;
  SignUpUser signUpUse = SignUpUser();
  Random random = Random(100);

  final _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _Formkey,
            child: Column(
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                ),
                Textfund(
                  suffixIcon: Icon(Icons.done,
                      size: 30,
                      color: greenIcon ? Colors.greenAccent : Colors.grey),
                  controller: Namecontroller,
                  hintText: 'Fullname',
                  labelText: 'Name',
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'field require';
                    } else if (value.length < 6) {
                      return 'full name not correct';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value.length > 5) {
                        greenIcon = true;
                      } else {
                        greenIcon = false;
                      }
                    });
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Textfund(
                  controller: Emailcontroller,
                  hintText: 'Email',
                  labelText: 'Email',
                  validator: (String? value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return 'email needed';
                    } else if (!emailValid) {
                      return 'invalid email combination';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Textfund(
                    controller: Usercontroller,
                    hintText: 'enter username',
                    labelText: 'username (optional)',
                    validator: (String? value) {
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                Textfund(
                    suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            if (isToggle == true) {
                              isToggle = false;
                            } else {
                              isToggle = true;
                            }
                          });
                        },
                        child: isToggle
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility)),
                    obscureText: isToggle,
                    controller: Passwordcontroller,
                    hintText: 'Password',
                    labelText: 'Password',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'password needed';
                      } else if (value.length < 6) {
                        return 'password should be morethan 6 character';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                Textfund(
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
                    controller: Confirmcontroller,
                    hintText: 'Confirm Password',
                    labelText: 'Confirm Password',
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'confirm password needed';
                      } else if (Passwordcontroller.text != value) {
                        return 'password do not match';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Switch(
                      activeColor: Color(0xfffDB3022),
                      value: (isSwitch),
                      onChanged: (value) {
                        setState(() {
                          isSwitch = value;
                        });
                      },
                    ),
                    InkWell(
                      child: Text(
                        'Terms and Condition',
                        style: TextStyle(color: Color(0XfffDB3022)),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an account?'),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Icon(
                        Icons.arrow_forward,
                        color: Color(0XfffDB3022),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                MaterialButton(
                  minWidth: double.infinity,
                  height: height * 0.07,
                  onPressed: () {
                    if (_Formkey.currentState!.validate() && isSwitch == true) {
                      setState(() {
                        circularProgressIndicator = true;
                      });
                      print('validated');
                      signUpUse
                          .signUpWithEmailAndPassword(
                            email: Emailcontroller.text,
                            password: Passwordcontroller.text,
                          )
                          .then((value) => {
                                if (value.first)
                                  {
                                    signUpUse.registeration(
                                        user: Users(
                                            Id: signUpUse.user!.uid,
                                            userName: Usercontroller.text,
                                            name: Namecontroller.text,
                                            email: Emailcontroller.text,
                                            password: Passwordcontroller.text,
                                            profileImage: '',
                                            accBalance: '0.0')),
                                    print(value.last),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.green,
                                      content: Text(' ${value.last}'),
                                    )),
                                    Navigator.pop(context),
                                    // // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Login()));
                                    print(value.last)
                                    //ScaffoldMessenger.of(context).showSnackBar()
                                  }
                                else
                                  {
                                    print(value.last),
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text('${value.last}'),
                                    ))
                                  }
                              });
                    }

                    /*
                    user: Users(
                              Id: signUpUse.user!.uid,
                              userName: Usercontroller.text,
                              name: Namecontroller.text,
                              email: Emailcontroller.text,
                              password: Passwordcontroller.text,
                              accBalance: 0.0)
                     */
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => Login()));
                    //} else {}
                    String Name = Namecontroller.text;
                    String Email = Emailcontroller.text;
                    String Password = Passwordcontroller.text;
                    String Confirm = Confirmcontroller.text;
                    print(
                        ' My Fullnames are ;$Name,\n$Email,\n$Password,\n$Confirm');
                  },
                  color: isSwitch == true ? Color(0XfffDB3022) : Colors.grey,
                  child: isSwitch && circularProgressIndicator == true
                      ? CircularProgressIndicator()
                      // Text(
                      //         'SIGN UP',
                      //         style: TextStyle(color: Colors.white),
                      //       )
                      : Text(
                          'SIGN UP',
                          style: TextStyle(color: Colors.white),
                        ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text('or login with social account'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 13,
                        backgroundImage: AssetImage('assets/images/img.png'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/img_2.png'),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
