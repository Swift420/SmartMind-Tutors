import 'package:bookworm1/Auth/login.dart';
import 'package:bookworm1/navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Listen to the authentication state changes stream
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check if there is data (user is authenticated)
          if (snapshot.hasData) {
            // User is authenticated, show the navigation screen
            return Navigation();
          } else {
            // User is not authenticated, show the login page
            return LoginPage();
          }
        },
      ),
    );
  }
}
