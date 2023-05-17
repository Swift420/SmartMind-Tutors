import 'package:bookworm1/Profile/my_requests.dart';
import 'package:bookworm1/Profile/my_tutoring.dart';
import 'package:bookworm1/Components/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileMain extends StatefulWidget {
  const ProfileMain({super.key});

  @override
  State<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends State<ProfileMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282828),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTutoring()),
                );
              },
              child: CustomCard(
                  title: "My Tutoring", icon: Icons.arrow_right_alt_rounded),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyRequests()),
                );
              },
              child: CustomCard(
                  title: "My Requests", icon: Icons.arrow_right_alt_rounded),
            ),
            SizedBox(height: 20),
            // CustomCard(
            //     title: "My Profile", icon: Icons.arrow_right_alt_rounded),
          ],
        ),
      ),
    );
  }
}
