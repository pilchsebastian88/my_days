import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewDayWidget extends StatefulWidget {
  const NewDayWidget(
    this.date,
    this.title, {
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final String title;

  @override
  State<NewDayWidget> createState() => _NewDayWidgetState();
}

class _NewDayWidgetState extends State<NewDayWidget> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(6),
          color: const Color.fromARGB(250, 240, 246, 96)),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              DateFormat('yyyy-MM-dd').format(widget.date),
              style: GoogleFonts.dancingScript(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.title,
            textAlign: TextAlign.justify,
            style: GoogleFonts.dancingScript(fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 1),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Rating:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 250, 103, 93),
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    itemSize: 30,
                    minRating: 1,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onRatingUpdate: (rating) => setState(() {
                      this.rating = rating;
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
