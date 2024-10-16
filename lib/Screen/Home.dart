import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mini/Data/Read.dart';
import 'package:mini/Screen/Profile.dart';
import 'package:mini/Screen/addForm.dart';

class Personlist extends StatefulWidget {
  const Personlist({super.key});

  @override
  State<Personlist> createState() => _PersonlistState();
}

class _PersonlistState extends State<Personlist> {
  List<Person> persons = [];

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  // ดึงข้อมูลจาก assets และเขียนไปยัง local storage ครั้งแรก
  Future<void> loadInitialData() async {
    final localFile = await _getLocalFile();
    if (!(await localFile.exists())) {
      final jsonData = await rootBundle.loadString('assets/Json/Person.json');
      await localFile.writeAsString(jsonData);
    }
    final jsonData = await localFile.readAsString();
    final List<dynamic> jsonList = json.decode(jsonData);
    setState(() {
      persons = jsonList.map((json) => Person.fromJson(json)).toList();
    });
  }

  // เขียนข้อมูลลง local storage
  Future<void> writeJsonData() async {
    final localFile = await _getLocalFile();
    List<Map<String, dynamic>> jsonData =
        persons.map((person) => person.toJson()).toList();
    await localFile.writeAsString(json.encode(jsonData));
  }

  // เข้าถึงไฟล์ใน local storage
  Future<File> _getLocalFile() async {
    if (kIsWeb) {
      // บนเว็บ ไม่มีการเข้าถึงไดเรกทอรีในลักษณะนี้
      throw UnsupportedError("การจัดการไฟล์ไม่ได้รับการสนับสนุนบนเว็บ");
    } else {
      final directory = await getApplicationDocumentsDirectory();
      return File('${directory.path}/Person.json');
    }
  }

  // ล้างข้อมูลทั้งหมด
  Future<void> clearData() async {
    setState(() {
      persons.clear(); // ล้างข้อมูลในลิสต์
    });
    await writeJsonData(); // เขียนข้อมูลที่ล้างลงในไฟล์ JSON
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "รายชื่อสมาชิก",
          style: GoogleFonts.niramit(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ), // ใช้ GoogleFonts โดยตรง
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 110, 255, 183),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              // เมื่อกดปุ่ม จะทำการล้างข้อมูล
              await clearData();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ข้อมูลถูกล้างแล้ว')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: persons.isEmpty
                  ? Center(
                      child: Text(
                        "ไม่มีสมาชิก",
                        style:
                            GoogleFonts.mali(), // ใช้ฟอนต์ GoogleFonts.mali()
                      ),
                    )
                  : ListView.builder(
                      itemCount: persons.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: persons[index].job.color,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Image.asset(
                                    persons[index].job.image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        title: Text(
                                          persons[index].name,
                                          style: GoogleFonts.mali(
                                              fontSize: 20,
                                              fontWeight: FontWeight
                                                  .bold), // ใช้ GoogleFonts.mali()
                                        ),
                                        subtitle: Text(
                                          "อายุ: ${persons[index].age} ปี อาชีพ: ${persons[index].job.title}",
                                          style: GoogleFonts.mali(
                                              fontWeight: FontWeight
                                                  .bold), // ใช้ GoogleFonts.mali()
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          FilledButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (ctx) => Profile(
                                                    person: {
                                                      'Name':
                                                          persons[index].name,
                                                      'Age': persons[index].age,
                                                      'Job': persons[index].job,
                                                      'Image': persons[index]
                                                          .job
                                                          .image,
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "รายละเอียด",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: FilledButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black),
                                          ),
                                          const SizedBox(width: 8),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
            SizedBox(
              width: 100,
              child: IconButton(
                onPressed: () async {
                  final newPerson = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (ctx) => const Addform()),
                  );

                  if (newPerson != null) {
                    setState(() {
                      persons.add(newPerson);
                    });
                    await writeJsonData();
                  }
                },
                icon: const Icon(Icons.person_add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
