class RequestsToBeTutored {
  String? title;
  String? name;
  String? budgetLowest;
  String? budgetHighest;
  String? category;
  String? description;
  String? contact;
  String? id;
  String? docid;

  RequestsToBeTutored(
      {this.title,
      this.name,
      this.budgetLowest,
      this.budgetHighest,
      this.category,
      this.description,
      this.contact,
      this.id,
      this.docid});

  RequestsToBeTutored.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    name = json['name'];
    budgetLowest = json['budget_lowest'];
    budgetHighest = json['budget_highest'];
    category = json['category'];
    description = json['description'];
    contact = json['contact'];
    id = json['id'];
    docid = json['docid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['name'] = this.name;
    data['budget_lowest'] = this.budgetLowest;
    data['budget_highest'] = this.budgetHighest;
    data['category'] = this.category;
    data['description'] = this.description;
    data['contact'] = this.contact;
    data['id'] = this.id;
    data['docid'] = this.docid;
    return data;
  }
}

List<RequestsToBeTutored> requestsToBeTutoredList = [
  RequestsToBeTutored(
    title: 'English Tutoring',
    name: 'Samantha',
    budgetLowest: '500',
    budgetHighest: '1000',
    category: 'CS',
    description:
        'I am looking for a tutor who can help me improve my English grammar and writing skills. I struggle If you can assist me, please contact me at 08012345678.',
    contact: '08012345678',
    id: '1',
  ),
  RequestsToBeTutored(
    title: 'Mathematics Tutoring',
    name: 'Alex',
    budgetLowest: '1500',
    budgetHighest: '2000',
    category: 'Math',
    description:
        'I am in need of a math tutor who can guide me in understanding complex calculus and trigonometry concepts.',
    contact: '08023456789',
    id: '2',
  ),
  RequestsToBeTutored(
    title: 'Web Development Tutoring',
    name: 'Olivia',
    budgetLowest: '3000',
    budgetHighest: '5000',
    category: 'IT',
    description:
        'I am seeking a web development tutor who can assist me with learning ReactJS and NodeJS. I have some basic knowledge of HTML and CSS but need guidance in building interactive web applications. I would like to work on projects and get hands-on experience. ',
    contact: '08034567890',
    id: '3',
  ),
  RequestsToBeTutored(
    title: 'Art History Tutoring',
    name: 'John',
    budgetLowest: '2000',
    budgetHighest: '3000',
    category: 'Language',
    description:
        'I am passionate about art history and would like to deepen my knowledge of the Renaissance period. I am seeking a tutor who can provide in-depth insights into the major artists, artworks, and historical context of that era.',
    contact: '08045678901',
    id: '4',
  ),
  RequestsToBeTutored(
    title: 'Chemistry Tutoring',
    name: 'Emily',
    budgetLowest: '1000',
    budgetHighest: '1500',
    category: 'Chemistry',
    description:
        'I require assistance in understanding organic chemistry concepts. I find it challenging to grasp reaction mechanisms and stereochemistry.',
    contact: '08056789012',
    id: '5',
  ),
];
