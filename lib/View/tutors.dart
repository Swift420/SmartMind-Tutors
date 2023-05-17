import 'package:bookworm1/Components/HomeCard.dart';
import 'package:bookworm1/Models/tutorClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF282828),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("Tutors").snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                final snap = snapshot.data!.docs;
                final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
                List<Tutor> tutorsList = [];
                tutorsList.clear();
                for (var doc in docs!) {
                  tutorsList
                      .add(Tutor.fromJson(doc.data() as Map<String, dynamic>));
                }
                return ListView.builder(
                  itemCount: tutorsList.length,
                  itemBuilder: ((context, index) {
                    return HomeCard(
                      title: tutorsList[index].title.toString(),
                      category: tutorsList[index].category.toString(),
                      contact: tutorsList[index].contact.toString(),
                      name: tutorsList[index].name.toString(),
                      price: tutorsList[index].price.toString(),
                    );
                  }),
                );
              } else {
                return Center(
                    child: Text(
                  "No Data",
                  style: TextStyle(color: Colors.white),
                ));
              }
            }));
  }
}
