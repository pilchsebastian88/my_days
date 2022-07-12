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
            children: const [
              NewDayWidget('some text 1'),
              NewDayWidget('some text 2'),
              NewDayWidget('some text 3'),
            ],
          )
        ],
      ),
    );
  }
}

class NewDayWidget extends StatelessWidget {
  const NewDayWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: const Color.fromARGB(250, 240, 246, 96)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.justify,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Rating:',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 103, 93),
                ),
              ),
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star),
              Icon(Icons.star),
            ],
          ),
        ],
      ),
    );
  }
}
