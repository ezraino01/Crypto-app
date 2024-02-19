import 'package:email_auth/email_auth.dart';
import 'package:ezraino/CustomizeTexT.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OTP extends StatefulWidget {

  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}
class _OTPState extends State<OTP> {
  TextEditingController emailController= TextEditingController();
  TextEditingController otpController= TextEditingController();
  void sendOTP() async {
    EmailAuth.sessionName = 'email authentication';
    var response = await EmailAuth.sendOtp(receiverMail: emailController.text);
    if (response) {
      print('.............................OTP sent');
    }else{print('................problems with sending OTP...................');
    }
  }

  void verifyOTP() async {
    EmailAuth.sessionName = 'verify code';
    var response = await EmailAuth.validate(
        receiverMail: emailController.text, userOTP: otpController.text);
    if(response){
      print('OTP verified');
    }else{
      print('invalid OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(actions: [Icon(Icons.add)],
leading: Text('hello world'),),

      body: Column(
        children: [
          Textfund(controller: emailController, validator: (String? value){},hintText: 'Enter email',
            suffixIcon: InkWell(onTap:(){verifyOTP();},child: Icon(Icons.add)),),

          Textfund(controller: otpController, validator: (String? value){},hintText: 'OTP',),
        MaterialButton(onPressed: (){})
        ],
      ),
    );
  }
}
