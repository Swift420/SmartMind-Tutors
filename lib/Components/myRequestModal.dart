import 'package:bookworm1/Models/requestsClass.dart';
import 'package:bookworm1/Models/tutorClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestModal extends StatefulWidget {
  @override
  _RequestModalState createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _budgetLowerController = TextEditingController();
  final TextEditingController _budgetHigherController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? _selectedCategory;

  final _formKey = GlobalKey<FormState>();

  List<String> _categories = ['Math', 'Physics', 'Language', "IT"];

  @override
  Widget build(BuildContext context) {
    String name = '';
    String contact = "";
    Future<DocumentSnapshot> getDocument() async {
      return await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
    }

    Future<void> fetchData() async {
      try {
        DocumentSnapshot snapshot = await getDocument();

        if (snapshot.exists) {
          // Document exists
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          // Access the fields in the data map
          setState(() {
            name = data['name'];
            contact = data['contact'];
          });
          // ...
        } else {
          // Document does not exist
          print("Document does not exist.");
        }
      } catch (error) {
        print("Error retrieving document: $error");
      }
    }

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> saveData(RequestsToBeTutored requestData) async {
      try {
        // await firestore.collection('Requests').add(requestData.toJson());

        CollectionReference collection =
            FirebaseFirestore.instance.collection('Requests');

        // Create a new document and retrieve the DocumentReference
        var docRef =
            await FirebaseFirestore.instance.collection("Requests").doc();

        docRef.set({
          "docid": docRef.id,
          "id": requestData.id,
          "name": requestData.name,
          "title": requestData.title,
          "description": requestData.description,
          "budget_highest": requestData.budgetHighest,
          "budget_lowest": requestData.budgetLowest,
          "category": requestData.category,
          "contact": requestData.contact,
        });
        print('Data saved successfully!');
      } catch (error) {
        print('Error saving data: $error');
      }
    }

    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the modal
        FocusScope.of(context).unfocus();
      },
      child: Container(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    maxLength: 15,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      counterText: '', // Remove the character counter text
                    ),
                    maxLength: 30, // Limit the maximum number of characters
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      } else if (value.length > 30) {
                        return 'Title must be within 40 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is required';
                      }
                      return null;
                    },
                    maxLength: 230,
                    maxLines:
                        5, // Set the maxLines property to fit 150 characters
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _contactController,
                    decoration: InputDecoration(
                      labelText: 'Contact',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Contact is required';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]*$')), // Allow only numeric input
                    ],
                    maxLength: 10,
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _budgetLowerController,
                    decoration: InputDecoration(
                      labelText: 'Budget Low',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Budget Low is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _budgetHigherController,
                    decoration: InputDecoration(
                      labelText: 'Budget High',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Budget High is required';
                      }
                      final budgetLow =
                          int.tryParse(_budgetLowerController.text);
                      final budgetHigh = int.tryParse(value);
                      if (budgetLow != null &&
                          budgetHigh != null &&
                          budgetHigh <= budgetLow) {
                        return 'Budget High must be higher than Budget Low';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Category',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    items: _categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      print(name);
                      print(contact);
                      if (_formKey.currentState!.validate()) {
                        // Save button pressed, perform your logic here
                        String title = _titleController.text;
                        String budgetlow = _budgetLowerController.text;
                        String budgetHigh = _budgetHigherController.text;
                        String desc = _descController.text;
                        String contact = _contactController.text;
                        String name = _nameController.text;
                        String category = _selectedCategory ?? '';

                        RequestsToBeTutored requestData = RequestsToBeTutored(
                            title: title,
                            name: name,
                            category: category,
                            contact: contact,
                            id: FirebaseAuth.instance.currentUser!.uid,
                            budgetHighest: budgetHigh,
                            budgetLowest: budgetlow,
                            description: desc);

                        await saveData(requestData);

                        // Close the modal
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
