import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Email_Verified.dart';
import 'package:my_app/Home%20Directory/Home_Page.dart';
import 'package:my_app/SignIn_Page.dart';
class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
          if(
          snapshot.data!.emailVerified
          ){
            return HomePage();
          }else{
            return EmailVerified();
          }
        } else{
          return SigninPage();
        }
      }),
    );
  }
}
