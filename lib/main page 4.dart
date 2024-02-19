import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ezraino/CustomizeTexT.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import 'Method/utility.dart';
import 'UserModel.dart';

class MainPage3 extends StatefulWidget {
  final Users user;
  const MainPage3({super.key, required this.user});

  @override
  State<MainPage3> createState() => _MainPage3State();
}

class _MainPage3State extends State<MainPage3> {
  XFile? fileImage;
  void selectImage() async {
    fileImage = await pickImage();
    setState(() {
      print(fileImage);
    });
  }

  SignUpUser signUpUser = SignUpUser();
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController firstEmailcontroller = TextEditingController();
  TextEditingController firstUsernamecontroller = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  bool isToggle = false;
  bool isToggled = false;
  bool loading = false;
  @override
  void initState() {
    firstNamecontroller.text = widget.user.name;
    firstEmailcontroller.text = widget.user.email;
    firstUsernamecontroller.text = widget.user.userName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XfffDB3022),
      appBar: AppBar(
        backgroundColor: Color(0XfffDB3022),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 30,
          ),
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                    ),
                    fileImage != null
                        ? Image.file(
                            File(fileImage!.path),
                            height: 70,
                            width: 70,
                          )
                        : widget.user.profileImage!.isNotEmpty
                            ? Image.network(widget.user.profileImage!,cacheHeight: 50,cacheWidth: 50,)
                            : Container(),
                    Positioned(
                        top: 60,
                        left: 60,
                        child: IconButton(
                          onPressed: () {
                            selectImage();
                            if (fileImage != null) {
                              SignUpUser()
                                  .uploadImage(
                                      file: fileImage!.path,
                                      userId: widget.user.Id)
                                  .then((value) => {
                                        if (value.first == true)
                                          {
                                            Fluttertoast.showToast(
                                                msg: value.last),
                                          }
                                        else
                                          {
                                            Fluttertoast.showToast(
                                                msg: value.last),
                                          }
                                      });
                            }
                          },
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                          ),
                        ))
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.user.email}',
                    style: TextStyle(fontSize: 20),
                  ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy('${widget.user.email}');
                      },
                      icon: Icon(Icons.content_copy))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.68,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text('Full Name'),
                  Textfund(
                      prefixIcon: Icon(Icons.person),
                      controller: firstNamecontroller,
                      validator: (String? value) {}),
                  Text('Email'),
                  Textfund(
                      prefixIcon: Icon(Icons.person),
                      controller: firstEmailcontroller,
                      validator: (String? value) {}),
                  Text('UserName'),
                  Textfund(
                      prefixIcon: Icon(Icons.person),
                      controller: firstUsernamecontroller,
                      validator: (String? value) {}),
                  SizedBox(
                    height: 15,
                  ),
                  Text('Phone number'),
                  Textfund(
                      prefixIcon: Icon(Icons.person),
                      controller: PhoneNumberController,
                      validator: (String? value) {}),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (isToggle == true&&isToggled==false) {
                                isToggle = false;
                              } else {
                                isToggle = true;
                              }
                            });
                          },
                          child: isToggle
                              ? Icon(Icons.check_circle_rounded,
                                  color: Colors.green)
                              : Icon(Icons.circle_outlined)),
                      Text(
                        'Male',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isToggled == true&&isToggle==false) {
                              isToggled = false;
                            } else {
                              isToggled = true;
                            }
                          });
                        },
                        child: isToggled
                            ? Icon(
                                Icons.check_circle_rounded,
                                color: Colors.green,
                              )
                            : Icon(Icons.circle_outlined),
                      ),
                      Text(
                        'Female',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                        setState(() {
                          loading = true;
                        });
                        signUpUser
                            .updateUser(
                                user: Users(
                                    Id: widget.user.Id,
                                    userName: firstUsernamecontroller.text,
                                    name: firstNamecontroller.text,
                                    email: firstEmailcontroller.text,
                                    password: widget.user.password,
                                    accBalance: widget.user.accBalance,
                                    phoneNumber: PhoneNumberController.text,
                                    profileImage: widget.user.profileImage))
                            .then((value) => {
                                  if (value.first == true)
                                    {
                                      setState(() {
                                        loading = false;
                                      }),
                                      Fluttertoast.showToast(msg: value.last),
                                    }
                                  else
                                    {
                                      Fluttertoast.showToast(msg: value.last),
                                      setState(() {
                                        loading = false;
                                      }),
                                    }
                                });
                      },
                      color: Color(0XfffDB3022),
                      child: Text(
                        'Save ',
                        style: TextStyle(fontSize: 20),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
