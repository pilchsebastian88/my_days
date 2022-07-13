import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_days/home/my_days/new_day_widget.dart';

class MyDaysPage extends StatefulWidget {
  MyDaysPage({
    Key? key,
  }) : super(key: key);

  final controller = TextEditingController();

  @override
  State<MyDaysPage> createState() => _MyDaysPageState();
}

class _MyDaysPageState extends State<MyDaysPage> {
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
            children: [
              TextField(
                controller: widget.controller,
              ),
              NewDayWidget('My day 1'),
              NewDayWidget('My day 2'),
              NewDayWidget('My day 3'),
            ],
          )
        ],
      ),
      bottomSheet: Image.asset(
        'images/bottomsheet_image.png',
      ),
    );
  }
}
