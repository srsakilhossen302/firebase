import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SignIn_Page.dart';
import 'Wrapper.dart';

class EmailVerified extends StatefulWidget {
  const EmailVerified({super.key});

  @override
  State<EmailVerified> createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {
  bool _isResending = false;
  bool _isChecking = false;
  Timer? _autoCheckTimer;

  @override
  void initState() {
    super.initState();
    // Auto-check every 5 seconds if email has been verified
    _autoCheckTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _checkVerification(silent: true);
    });
  }

  @override
  void dispose() {
    _autoCheckTimer?.cancel();
    super.dispose();
  }

  Future<void> _resendVerificationEmail() async {
    setState(() => _isResending = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.sendEmailVerification();
        Get.snackbar(
          'Email Sent',
          'Verification link sent to ${user.email}',
          backgroundColor: Colors.green.shade100,
          colorText: Colors.green.shade800,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend email. Please wait a moment and try again.',
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _checkVerification({bool silent = false}) async {
    if (!silent) setState(() => _isChecking = true);
    try {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && user.emailVerified) {
        _autoCheckTimer?.cancel();
        Get.offAll(() => const Wrapper());
      } else if (!silent) {
        Get.snackbar(
          'Not Verified Yet',
          'Please check your inbox and click the verification link.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      if (!silent) {
        Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      }
    } finally {
      if (mounted && !silent) setState(() => _isChecking = false);
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(() => const SigninPage());
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Your Email'),
        actions: [
          TextButton(
            onPressed: _signOut,
            child: const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Animated email icon
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.8, end: 1.0),
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: const Icon(
                  Icons.mark_email_unread_rounded,
                  size: 100,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Verify Your Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),

              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 15, height: 1.6),
                  children: [
                    const TextSpan(text: 'We sent a verification link to:\n'),
                    TextSpan(
                      text: user?.email ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const TextSpan(
                      text: '\n\nPlease check your inbox and click the link to verify your account.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'The page will refresh automatically once verified.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
              ),

              const SizedBox(height: 40),

              // Check verification button
              SizedBox(
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: _isChecking ? null : () => _checkVerification(),
                  icon: _isChecking
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.refresh_rounded),
                  label: Text(
                    _isChecking ? 'Checking...' : 'I\'ve Verified My Email',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Resend button
              OutlinedButton.icon(
                onPressed: _isResending ? null : _resendVerificationEmail,
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: _isResending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send_rounded),
                label: Text(
                  _isResending ? 'Sending...' : 'Resend Verification Email',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
