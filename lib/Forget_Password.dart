import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_app/Home_Page.dart';

import 'SignIn_Page.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();

  forgetPassword() async {

    try {
     await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);

    } on FirebaseAuthException catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'failed')),
      );
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Password Reset Successful."
          " Check yourEmail for the reset link and log in your new password"))
    );
    Get.offAll(SigninPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: "Please Enter Your Email",
                label: Text("Email"),
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:   ElevatedButton(onPressed: forgetPassword, child: Text("Send link")),
          ),
        ],
      ),
    );
  }
}
