import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeCard extends StatefulWidget {
  final String title;
  final String name;
  final String category;
  final String contact;
  final String price;

  const HomeCard({
    Key? key,
    required this.title,
    required this.name,
    required this.category,
    required this.contact,
    required this.price,
  }) : super(key: key);

  @override
  State<HomeCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: Card(
        color: Color(0xFF404040),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 2.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 14, top: 8),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                getColorBasedOnCondition(widget.category),
                            radius: 9,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Expanded(
                            child: Text(
                              '${widget.title}',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${widget.name}',
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${widget.contact}',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'N\$ ${widget.price}',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
