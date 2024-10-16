import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic> person;
  const Profile({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile ของ ${person['Name']}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Image.asset(person['Image']),
            width: 500,
            height: 200,
          ),
          const SizedBox(height: 20),
          ListTile(
            title: Text("ชื่อ : ${person['Name']}",
                style: const TextStyle(fontSize: 22)),
            subtitle: Text(
              "อายุ : ${person['Age']} ปี, อาชีพ : ${person['Job'].title}",
              style: GoogleFonts.mali(fontSize: 20),
            ),
          ),
          Image.network(
            'https://st3.depositphotos.com/2633985/33417/v/380/depositphotos_334176002-stock-illustration-cat-kitty-face-head-body.jpg',
            width: 250,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.error,
                size: 100,
                color: Colors.red,
              );
            },
          )
        ],
      ),
    );
  }
}
