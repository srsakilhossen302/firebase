import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_app/SignIn_Page.dart';
import 'package:my_app/Wrapper.dart';
import 'Home Directory/Home_Page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  signUp() async {

    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Get.offAll(Wrapper());

    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,

      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Sign Up failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sing Up Page")),

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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "Please Enter Your password",
                label: Text("password"),
                prefixIcon: Icon(Icons.password),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: signUp, child: Text("Sign Up")),
          ),

          SizedBox(height: 50),

          Row(
            children: [
              Text("Already Have Account"),

              TextButton(onPressed: () {
               Get.to(SigninPage());
              }, child: Text("Sign In")),
            ],
          ),

        ],
      ),
    );
  }
}
