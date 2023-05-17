import 'package:bookworm1/Components/HomeCard.dart';
import 'package:bookworm1/Components/myTutoringModal.dart';
import 'package:bookworm1/Models/tutor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTutoring extends StatefulWidget {
  const MyTutoring({super.key});

  @override
  State<MyTutoring> createState() => _MyTutoringState();
}

class _MyTutoringState extends State<MyTutoring> {
  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: MyModal(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282828),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Center(child: Text("My Tutors")),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            _showModal(context);
          })),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Tutors")
              .where("id",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
              .snapshots(),
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
                  return GestureDetector(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text(
                                'Are you sure you want to delete this item?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // Delete the document from Firestore
                                  FirebaseFirestore.instance
                                      .collection('Tutors')
                                      .doc(tutorsList[index].docid)
                                      .delete();

                                  // Close the modal dialog
                                  Navigator.pop(context);
                                },
                                child: Text('Delete'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Close the modal dialog
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: HomeCard(
                      title: tutorsList[index].title.toString(),
                      category: tutorsList[index].category.toString(),
                      contact: tutorsList[index].contact.toString(),
                      name: tutorsList[index].name.toString(),
                      price: tutorsList[index].price.toString(),
                    ),
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
          }),
    );
  }
}
