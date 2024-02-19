import 'package:ezraino/BusinessLogic/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserModel.dart';

class Mainpage5 extends StatefulWidget {
  const Mainpage5({super.key});

  @override
  State<Mainpage5> createState() => _Mainpage5State();
}

class _Mainpage5State extends State<Mainpage5> {
  final service = SignUpUser();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_outlined))),
      body: FutureBuilder(
          future: service.getAllUsers(), builder: (context, snapshot) {
            if(snapshot.connectionState== ConnectionState.waiting){
              return CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            List<Users> users=snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
                itemBuilder: (context, index){

              return Container(
                child: ListTile(
                  leading: users[index].profileImage!.isNotEmpty?CircleAvatar(
                    backgroundImage:NetworkImage(users[index].profileImage!),
                  ):const CircleAvatar(),
                  title: Text(users[index].email),
                ),
              );
            });
      }),
    );
  }
}
