import 'dart:io';
import 'dart:typed_data';

import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:ezraino/Method/utility.dart';
import 'package:ezraino/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class MainPage2 extends StatefulWidget {
  final Users user;
  const MainPage2({
    super.key,
    required this.user,
  });

  @override
  State<MainPage2> createState() => _MainPage2State();
}

class _MainPage2State extends State<MainPage2> {
  XFile? fileImage;
  void selectImage() async {
    fileImage = await pickImage();
    // signUpUser.updateImageUrl(fileImage!.path).then((value) => {
    //   if(value.first=true){
    //     print(value.last)
    //   }else{
    //     print(value.last)
    //   }
    // });
    setState(() {
      //String fileImage=fileImage.path;
      print(fileImage);
    });
  }
  TextEditingController firstNamecontroller = TextEditingController();
  TextEditingController firstUsernamecontroller = TextEditingController();
  SignUpUser signUpUser = SignUpUser();
  bool loading = false;
  @override
  void initState() {
    firstNamecontroller.text = widget.user.name;
    firstUsernamecontroller.text = widget.user.userName;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'View Profile',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img_3.png'),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Click to edit your full name and user name\n'
                ' Click of \'Update Profile\' '
                'once you are done.'
                '\n a successful message will appear if it was succcessful,'
                ' but you csn re-edit if not successful',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.black),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Edit full name'),
                controller: firstNamecontroller,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: firstUsernamecontroller,
                decoration: InputDecoration(hintText: 'Edit user name'),
              ),
              SizedBox(
                height: 20,
              ),
              fileImage != null
                  ? Image.file(
                      File(fileImage!.path),
                      height: 70,
                      width: 70,
                    )
                  : widget.user.profileImage != null
                      ? Image.network(widget.user.profileImage!)
                      : Container(),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: InkWell(
                        onTap: () {
                          selectImage();
                          if (fileImage != null) {
                            signUpUser
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
                          } else {}
                        },
                        child: Icon(
                          Icons.add_a_photo,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              MaterialButton(
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
                              email: widget.user.email,
                              password: widget.user.password,
                              accBalance: '0.0'))
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
                color: Colors.red,
                child: Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
