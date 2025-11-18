
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Wrapper.dart';

class EmailVerified extends StatefulWidget {
  const EmailVerified({super.key});
  @override
  State<EmailVerified> createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {
  @override
  void initState(){
    sendverifylink();
    super.initState();
  }

  sendverifylink()async{
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification().then((value) => {

      Get.snackbar("", "Verification link sent your Email", margin: EdgeInsets.all(40))
    });
  }
  reload()async{
    await FirebaseAuth.instance.currentUser!.reload().then((value) => {
      Get.offAll(Wrapper())
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Email Verified"),
      ),
      body: Column(
        children: [
          Center(
            child: Text(" Verification link sent your Email,"
                " Please Check your Email and click the verification link. "
                "After verifying , tap the Refresh button below to continue."),
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: (){
            Get.offAll(Wrapper());
          }, child: Text("Sign Up"))
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (()=> reload()),
      child: Icon(Icons.restart_alt_rounded),
      ),

    );
  }
}
