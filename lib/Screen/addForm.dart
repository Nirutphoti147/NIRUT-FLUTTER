import 'package:flutter/material.dart';
import 'package:mini/Data/Read.dart';

class Addform extends StatefulWidget {
  const Addform({
    super.key,
  });

  @override
  State<Addform> createState() => _AddformState();
}

class _AddformState extends State<Addform> {
  final _formkey = GlobalKey<FormState>();
  String _name = '';
  int _age = 20;
  Jobs _job = Jobs.Engineer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "ฟอร์มเพิ่มสมาชิก",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 156, 255, 157),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      label: Text(
                        "ชื่อ",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "โปรดระบุชื่อ";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text(
                      "อายุ",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "โปรดระบุอายุ";
                      }
                      if (int.tryParse(value) == null) {
                        return "อายุต้องเป็นตัวเลข";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _age = int.parse(value!);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<Jobs>(
                      value: _job,
                      decoration: const InputDecoration(
                        label: Text(
                          "อาชีพ",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      items: Jobs.values.map((key) {
                        return DropdownMenuItem<Jobs>(
                          value: key,
                          child: Text(key.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _job = value!;
                        });
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        _formkey.currentState!.save();
                        _formkey.currentState!.reset();
                        final newPerson = Person(
                          name: _name,
                          age: _age.toString(),
                          job: _job,
                        );

                        Navigator.pop(context, newPerson);
                      }
                    },
                    child: const Text(
                      "บันทึก",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style: FilledButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 77, 71, 250)),
                  )
                ],
              ))),
    );
  }
}
