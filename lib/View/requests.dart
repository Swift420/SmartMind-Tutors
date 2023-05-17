import 'package:bookworm1/Models/requestsClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AskForHelp extends StatefulWidget {
  const AskForHelp({super.key});

  @override
  State<AskForHelp> createState() => _AskForHelpState();
}

class _AskForHelpState extends State<AskForHelp> {
  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
        backgroundColor: const Color(0xFF282828),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("Requests").snapshots(),
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
                    return SizedBox(
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
