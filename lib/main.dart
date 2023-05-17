import 'package:bookworm1/Auth/auth_page.dart';
import 'package:bookworm1/Auth/login.dart';
import 'package:bookworm1/View/Profile/my_requests.dart';
import 'package:bookworm1/View/Profile/my_tutoring.dart';
import 'package:bookworm1/View/Profile/profile_main.dart';
import 'package:bookworm1/View/requests.dart';
import 'package:bookworm1/View/tutors.dart';
import 'package:bookworm1/View/navigation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
