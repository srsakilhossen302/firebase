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
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading indicator while waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          }

          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            if (user.emailVerified) {
              return const HomePage();
            } else {
              return const EmailVerified();
            }
          } else {
            return const SigninPage();
          }
        },
      ),
    );
  }
}
