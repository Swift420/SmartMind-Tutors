import 'package:bookworm1/View/Profile/profile_main.dart';
import 'package:bookworm1/View/requests.dart';
import 'package:bookworm1/View/tutors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    Home(),
    AskForHelp(),
    ProfileMain(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282828),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Center(child: Text("SmartMinds Tutors")),
        actions: [
          GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              child: Icon(Icons.logout_outlined))
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black26,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.blue,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.school,
            ),
            label: 'Tutors',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
