class Tutor {
  String? title;
  String? name;
  String? price;
  String? category;
  String? contact;
  String? id;
  String? docid;

  Tutor(
      {this.title,
      this.name,
      this.price,
      this.category,
      this.contact,
      this.id,
      this.docid});

  Tutor.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    price = json['price'];
    category = json['category'];
    contact = json['contact'];
    id = json['id'];
    docid = json['docid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['price'] = this.price;
    data['category'] = this.category;
    data['contact'] = this.contact;
    data['id'] = this.id;
    data['docid'] = this.docid;
    return data;
  }
}

List<Tutor> tutors = [
  Tutor(
    id: "1",
    title: "Math Tutoring",
    name: "John",
    price: "50",
    category: "Math",
    contact: "123456789",
  ),
  Tutor(
    id: "2",
    title: "English Tutoring",
    name: "Sarah",
    price: "40",
    category: "Language",
    contact: "987654321",
  ),
  Tutor(
    id: "3",
    title: "Science Tutoring",
    name: "Mike",
    price: "60",
    category: "Physics",
    contact: "456789123",
  ),
  Tutor(
    id: "4",
    title: "History Tutoring",
    name: "Emily",
    price: "35",
    category: "Chemistry",
    contact: "321654987",
  ),
  Tutor(
    id: "5",
    title: "Programming Tutoring",
    name: "David",
    price: "70",
    category: "IT",
    contact: "789123456",
  ),
];
