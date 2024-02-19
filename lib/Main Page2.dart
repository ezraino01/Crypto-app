import 'package:ezraino/Registeration%20Page.dart';
import 'package:ezraino/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPAGE1 extends StatefulWidget {
  final User? user;
  final double? total;
  final double? buyAmount;
  final double? transferAmount;
  const MainPAGE1(
      {super.key,
        this.user,
        this.total,
        this.transferAmount,
        this.buyAmount});
  @override
  State<MainPAGE1> createState() => _MainPAGE1State();
}

class _MainPAGE1State extends State<MainPAGE1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_new_rounded),
          ),
          backgroundColor: Color(0xfffdb3320)),
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: Color(0xfffdb3320),
            child: widget.transferAmount == null
                ? Text(
                    'Amount Buy: \$${widget.buyAmount}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )
                : Text(
                    'Amount sent:\$${widget.transferAmount}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 80,
            width: double.infinity,
            color: Color(0xfffdb3320),
            child: Text(
              'Account Balance:\$${widget.total}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
          ),
          SizedBox(
            child: Text(
              'Thanks for choosing Zraino Tech',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            height: 30,
          ),
          MaterialButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Investment()));
            },
            child: Text('Click to Sign Out'),
            color: Color(0xfffdb3320),
          )
        ],
      ),
    );
  }
}
