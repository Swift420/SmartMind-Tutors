import 'package:bookworm1/Components/myRequestModal.dart';
import 'package:bookworm1/Components/myTutoringModal.dart';
import 'package:bookworm1/Models/requestsClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  Color getColorBasedOnCondition(String value) {
    if (value == 'Chemistry') {
      return Colors.red;
    } else if (value == "IT") {
      return Colors.pink;
    } else if (value == 'Language') {
      return Colors.purple;
    } else if (value == 'Physics') {
      return Colors.blue;
    } else if (value == 'Math') {
      return Colors.yellow;
    } else {
      return Colors.green;
    }
  }

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
            child: RequestModal(),
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
        title: const Center(child: Text("My Requests")),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (() {
            _showModal(context);
          })),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("Requests")
              .where("id",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              final snap = snapshot.data!.docs;
              final List<QueryDocumentSnapshot>? docs = snapshot.data?.docs;
              List<RequestsToBeTutored> requestList = [];
              requestList.clear();
              for (var doc in docs!) {
                requestList.add(RequestsToBeTutored.fromJson(
                    doc.data() as Map<String, dynamic>));
              }
              return ListView.builder(
                itemCount: requestList.length,
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
                                      .collection('Requests')
                                      .doc(requestList[index].docid)
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
                    child: SizedBox(
                      height: 250.0,
                      child: Card(
                        color: Color(0xFF404040),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 2.0,
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 14, top: 8),
                                    child: IntrinsicWidth(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "Budget: N\$ ${requestList[index].budgetLowest} - ${requestList[index].budgetHighest}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Row(
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor:
                                                      getColorBasedOnCondition(
                                                          requestList[index]
                                                              .category
                                                              .toString()),
                                                  radius: 9,
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${requestList[index].title}",
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0, top: 5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(
                                                    Icons.notes_rounded,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${requestList[index].description}",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 2.0, bottom: 2, left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${requestList[index].name}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone_android,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '${requestList[index].contact}',
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
