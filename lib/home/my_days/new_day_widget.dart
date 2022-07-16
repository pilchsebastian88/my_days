import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class NewDayWidget extends StatefulWidget {
  const NewDayWidget(
    this.title,
    this.date, {
    Key? key,
  }) : super(key: key);

  final String title;
  final double date;

  @override
  State<NewDayWidget> createState() => _NewDayWidgetState();
}

class _NewDayWidgetState extends State<NewDayWidget> {
  var rating = 1.0;

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
          Text(widget.date.toString()),
          Text(
            widget.title,
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 1),
            child: Container(
              padding: EdgeInsets.all(4),
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
                    itemSize: 30,
                    updateOnDrag: true,
                    minRating: 1,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (newValue) => setState(() {
                      rating = newValue;
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
