import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Forget_Password.dart';
import 'package:my_app/Home_Page.dart';
import 'package:my_app/Sign_Up.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    /// Check if user is already signed in
    if (_auth.currentUser != null) {
      Get.offAll(HomePage());
    }
  }

  /// Email / Password Sign-In
  signin() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      Get.offAll(HomePage());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  /// Google Sign-In
  Future<void> gSignIn() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? gUser = await googleSignIn.signIn();
      if (gUser == null) return; /// User cancelled

      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      /// Firebase sign-in
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      /// Optional: check if user exists in Firebase
      if (userCredential.user != null) {
        Get.offAll(HomePage());
      }
    } catch (e) {
      Get.snackbar("Google Sign-In Error", e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// Email TextField
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                label: Text("Email"),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 10),

            /// Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Password"),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 10),

            /// Forget Password
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () => Get.to(ForgetPassword()),
                child: const Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            /// Email/Password Sign-In Button
            ElevatedButton(
              onPressed: signin,
              child: const Text("Sign In"),
            ),
            const SizedBox(height: 20),

            /// Google Sign-In Button
            ElevatedButton(
              onPressed: gSignIn,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.g_mobiledata, size: 30, color: Colors.red),
                  SizedBox(width: 8),
                  Text("Sign In with Google"),
                ],
              ),
            ),
            const SizedBox(height: 40),

            /// Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Get.to(SignUp()),
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
