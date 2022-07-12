import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDaysPage extends StatefulWidget {
  const MyDaysPage({
    Key? key,
  }) : super(key: key);

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
            children: const [
              NewDayWidget('some text 1'),
              NewDayWidget('some text 2'),
              NewDayWidget('some text 3'),
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

class NewDayWidget extends StatefulWidget {
  const NewDayWidget(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  State<NewDayWidget> createState() => _NewDayWidgetState();
}

class _NewDayWidgetState extends State<NewDayWidget> {
  var rating = 0;

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
            widget.title,
            textAlign: TextAlign.justify,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Rating:',
                style: TextStyle(
                  color: Color.fromARGB(255, 250, 103, 93),
                ),
              ),
              RatingBar.builder(
                itemSize: 35,
                updateOnDrag: true,
                minRating: 1,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) => setState(() {
                  rating = rating;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
