import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
