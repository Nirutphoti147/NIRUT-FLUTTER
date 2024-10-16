import 'package:flutter/material.dart';

enum Jobs {
  Engineer(
      title: "Engineer",
      image: "assets/Image/pic1.png",
      color: Color.fromARGB(255, 126, 234, 240)),
  Doctor(
      title: "Doctor",
      image: "assets/Image/pic2.png",
      color: Color.fromARGB(255, 231, 195, 255)),
  Teacher(
      title: "Teacher",
      image: "assets/Image/pic3.png",
      color: Color.fromARGB(255, 190, 255, 194));

  const Jobs({required this.title, required this.image, required this.color});
  final String title;
  final String image;
  final Color color;

  static Jobs fromString(String jobString) {
    switch (jobString) {
      case "Doctor":
        return Jobs.Doctor;
      case "Engineer":
        return Jobs.Engineer;
      case "Teacher":
        return Jobs.Teacher;
      default:
        throw Exception('Job not found: $jobString');
    }
  }
}

class Person {
  final String name;
  final String age;
  final Jobs job;
  //final String image;

  Person({
    required this.name,
    required this.age,
    required this.job,
    //required this.image,
  });

  //แปลงข้อมูล Person เป็น json
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Age': age,
      'Job': job.name, // ส่งชื่อ job กลับในรูปแบบ string
      'Image': job.image,
    };
  }

  //แปลงจาก json เป็น person
  factory Person.fromJson(Map<String, dynamic> json) {
    print('Converting JSON: $json');
    return Person(
      name: json['Name'],
      age: json['Age'],
      job: Jobs.fromString(json['Job']),
      //image: json['Image'],
    );
  }
  String get image => job.image;
}
