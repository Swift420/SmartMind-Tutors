import 'package:bookworm1/Models/requestsClass.dart';
import 'package:bookworm1/Models/tutorClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyModal extends StatefulWidget {
  @override
  _MyModalState createState() => _MyModalState();
}

class _MyModalState extends State<MyModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String? _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  List<String> _categories = ['Math', 'Physics', 'Language', "IT"];

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> saveData(Tutor requestData) async {
      try {
        CollectionReference collection =
            FirebaseFirestore.instance.collection('Tutors');

        // Create a new document and retrieve the DocumentReference
        var docRef =
            await FirebaseFirestore.instance.collection("Tutors").doc();

        docRef.set({
          "docid": docRef.id,
          "id": requestData.id,
          "name": requestData.name,
          "title": requestData.title,
          "price": requestData.price,
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
                    ),
                    maxLength:
                        30, // Limit the maximum number of characters to 30
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title is required';
                      }
                      return null;
                    },
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
                    controller: _priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    keyboardType:
                        TextInputType.number, // Set the keyboard type to number
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^[0-9]*$')), // Allow only numeric input
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Price is required';
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
                      if (_formKey.currentState!.validate()) {
                        // Save button pressed, perform your logic here
                        String title = _titleController.text;
                        String name = _nameController.text;
                        String contact = _contactController.text;
                        String price = _priceController.text;
                        String category = _selectedCategory ?? '';

                        Tutor requestData = Tutor(
                            title: title,
                            name: name,
                            category: category,
                            contact: contact,
                            id: FirebaseAuth.instance.currentUser!.uid,
                            price: price);

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
