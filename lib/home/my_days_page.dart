import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDaysPage extends StatelessWidget {
  const MyDaysPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(236, 2, 172, 245),
      appBar: AppBar(
        title: Text(
          'MyDays',
          style: GoogleFonts.dancingScript(fontSize: 40, color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(236, 1, 189, 253),
      ),
      body: ListView(
        children: [
          Column(
            children: const [],
          )
        ],
      ),
    );
  }
}
