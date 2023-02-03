import 'dart:io';

class Resume {
  File? image;
  String? name;
  String? title;
  String? bio;
  String? phone;
  String? email;
  String? location;
  List<Works> works;
  List<Education> education;
  List<Skills> skills;

  Resume(
      {this.image,
      this.name,
      this.title,
      this.bio,
      this.phone,
      this.email,
      this.location,
      required this.works,
      required this.education,
      required this.skills});
}

class Works {
  String? id;
  String? enterpraise;
  String? title;
  String? description;

  Works({this.id, this.enterpraise, this.title, this.description});
}

class Education {
  String? id;
  String? school;
  String? title;
  String? description;

  Education({this.id, this.school, this.title, this.description});
}

class Skills {
  String? id;
  String? title;

  Skills({this.id, this.title});
}

/*
{
    "name": "",
    "title": "",
    "bio": "",
    "phone": "",
    "email": "",
    "location": "",
    "works": [
        {
            "id":"",
            "enterpraise": "",
            "title": "",
            "description": ""
        }
    ],
    "education": [
        {
            "id":"",
            "school": "",
            "title": "",
            "description": ""
        }
    ],
    "skills":[
      {
        "id":"",
        "title":""
      }
    ]
}
*/

/*
class Resume {
  File? image;
  String? name;
  String? title;
  String? bio;
  String? phone;
  String? email;
  String? location;
  late List<Works> works;
  late List<Education> education;
  late List<Skills> skills;

  Resume(
      {this.name,
      this.title,
      this.bio,
      this.phone,
      this.email,
      this.location,
      required this.works,
      required this.education,
      required this.skills});

  Resume.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    title = json['title'];
    bio = json['bio'];
    phone = json['phone'];
    email = json['email'];
    location = json['location'];
      json['works'].forEach((v) {
        works.add(new Works.fromJson(v));
      });
      json['education'].forEach((v) {
        education.add(new Education.fromJson(v));
      });
      json['skills'].forEach((v) {
        skills.add(new Skills.fromJson(v));
      });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['title'] = this.title;
    data['bio'] = this.bio;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['location'] = this.location;
    if (this.works != null) {
      data['works'] = this.works.map((v) => v.toJson()).toList();
    }
    if (this.education != null) {
      data['education'] = this.education.map((v) => v.toJson()).toList();
    }
    if (this.skills != null) {
      data['skills'] = this.skills.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Works {
  String? id;
  String? enterpraise;
  String? title;
  String? description;

  Works({this.id, this.enterpraise, this.title, this.description});

  Works.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enterpraise = json['enterpraise'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enterpraise'] = this.enterpraise;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Education {
  String? id;
  String? school;
  String? title;
  String? description;

  Education({this.id, this.school, this.title, this.description});

  Education.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    school = json['school'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['school'] = this.school;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}

class Skills {
  String? id;
  String? title;

  Skills({this.id, this.title});

  Skills.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
*/