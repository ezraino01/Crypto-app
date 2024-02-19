import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:ezraino/CustomizeTexT.dart';
import 'package:ezraino/Login%20Page.dart';
import 'package:ezraino/Method/buy%20METHOD.dart';
import 'package:ezraino/UserModel.dart';
import 'package:ezraino/main%20Page%206.dart';
import 'package:ezraino/main%20page%205.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Method/Transaction METHOD.dart';
import 'Main Page2.dart';
import 'main page 3.dart';
import 'main page 4.dart';

class MainPAGE extends StatefulWidget {
  final Users user;
  const MainPAGE({super.key, required this.user});

  @override
  State<MainPAGE> createState() => _MainPAGEState();
}

class _MainPAGEState extends State<MainPAGE> {
  TextEditingController Amountcontroller = TextEditingController();
  TextEditingController Emailcontroller = TextEditingController();
  TextEditingController BuyEmailcontroller = TextEditingController();
  TextEditingController buyAmountcontroller = TextEditingController();

  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController firstEmailcontroller = TextEditingController();
  TextEditingController firstUsernamecontroller = TextEditingController();
  TextEditingController userNAME = TextEditingController();
  // Method method = Method();
  // Method1 method1 = Method1();
  double total = 0;
  double transferAmount = 0;
  double buyAmount = 0;
  SignUpUser signUpUser = SignUpUser();
  String fullname = '';
  String username = '';
  bool loading = false;

  @override
  void initState() {
    firstNamecontroller.text = widget.user.name;
    firstUsernamecontroller.text = widget.user.userName;
    print('..............................${widget.user.userName}');
    // TODO: implement initState
    super.initState();
  }

  final _Formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey,
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                decoration: (BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50)),
                    color: Colors.black,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.profileImage!)))),
                height: height * 0.25,
                width: double.infinity,
              ),
              TextFormField(
                controller: firstNamecontroller,
              ),
              TextFormField(controller: firstUsernamecontroller),
              // Text(
              //   'Name:${widget.user.name}',
              //   style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black45,
              //       fontWeight: FontWeight.w900),
              // ),
              Text(
                'Email:${widget.user.email}',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900),
              ),
              // Text(
              //   'Username:${widget.user.userName}',
              //   style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.black45,
              //       fontWeight: FontWeight.w900),
              // ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 5,
                width: double.infinity,
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage3(
                                    user: widget.user,
                                  )));
                    },
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.send,
                    size: 30,
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainPage2(
                                    user: widget.user,
                                  )));
                    },
                    child: Text(
                      'Sent',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.drafts,
                    size: 30,
                    color: Colors.black,
                  ),
                  Text(
                    'Draft',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.call_received,
                    size: 30,
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Mainpage6()));
                    },
                    child: Text(
                      'Receive',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.black,
                  ),
                  InkWell(onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Mainpage5()));
                  },
                    child: Text(
                      'Settings',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.black,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'LogOut',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(
            'DashBoard',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          backgroundColor: Color(0xFFFDB3022),
          // title: /*Text('${widget.user!.accBalance}'),*/
          //     Text(widget.user!.accBalance.toString())
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _Formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      'Total Balance (Usdt)=${widget.user.accBalance}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45),
                    ),
                    height: height * 0.08,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        'Sell Usdt(Erc-20)',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                  Textfund(
                    controller: Amountcontroller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'required field';
                      }
                    },
                    hintText: 'enter amount',
                    labelText: 'enter amount',
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Textfund(
                    controller: Emailcontroller,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'field require';
                      }
                    },
                    hintText: 'enter receivers email',
                    labelText: 'email',
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        if (_Formkey.currentState!.validate()) {
                          transferAmount = double.parse(Amountcontroller.text);
                          signUpUser
                              .transferMoney(
                                senderEmail: widget.user.email,
                                receiverEmail: Emailcontroller.text,
                                amount: transferAmount,
                              )
                              .then((value) => {
                                    if (value.first == true)
                                      {Fluttertoast.showToast(msg: value.last)}
                                    else
                                      {
                                        Fluttertoast.showToast(msg: value.last),
                                        setState(() {
                                          loading = false;
                                        })
                                      }
                                  });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MainPAGE1(
                          //               total: total,
                          //               transferAmount: transferAmount,
                          //             )));
                        }
                        // total = method.transfer(Emailcontroller.text,
                        //     transferAmount );
                      });
                    },
                    color: Color(0xFFFDB3022),
                    child: Text(
                      'Send',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: Color(0xfffdb3320),
                  ),
                  Row(
                    children: [
                      Text(
                        'Buy Usdt(Erc-20)',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black45),
                      ),
                    ],
                  ),
                  // Textfund(
                  //   controller: buyAmountcontroller,
                  //   validator: (String? value) {
                  //     if (value!.isEmpty) {
                  //       return 'field required';
                  //     }
                  //   },
                  //   hintText: 'enter amount',
                  //   labelText: 'enter amount',
                  // ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                  // Textfund(
                  //   controller: BuyEmailcontroller,
                  //   validator: (String? value) {
                  //     if (value!.isEmpty) {
                  //       return 'field required';
                  //     }
                  //   },
                  //   hintText: 'enter receivers email',
                  //   labelText: 'email',
                  // ),
                  // MaterialButton(
                  //   onPressed: () {
                  //     if (_Formkey.currentState!.validate()) {
                  //       setState(() {
                  //         buyAmount = double.parse(buyAmountcontroller.text);
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => MainPAGE1(
                  //                       total: total,
                  //                       buyAmount: buyAmount,
                  //                     )));
                  //         // total = method1.buyamount(BuyEmailcontroller.text,
                  //         //     buyAmount, widget.user!.accBalance);
                  //       });
                  //     }
                  //   },
                  //   color: Colors.green,
                  //   child: Text(
                  //     'Buy',
                  //     style: TextStyle(color: Colors.white, fontSize: 20),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ));
  }
}
