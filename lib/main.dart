import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini/Screen/Home.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Project",
      theme: ThemeData(
        textTheme: GoogleFonts.niramitTextTheme(),
      ),
      home: const Personlist(),
    );
  }
}
