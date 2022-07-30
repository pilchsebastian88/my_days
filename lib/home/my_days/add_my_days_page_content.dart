import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddMyDaysPageContent extends StatefulWidget {
  const AddMyDaysPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);
  final Function onSave;

  @override
  State<AddMyDaysPageContent> createState() => _AddMyDaysPageContentState();
}

class _AddMyDaysPageContentState extends State<AddMyDaysPageContent> {
  DateTime date = DateTime.now();
  var titleInput = '';
  final rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Add new day',
            style: GoogleFonts.dancingScript(
              fontSize: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (newValue) {
                setState(() {
                  titleInput = newValue;
                });
              },
              decoration: InputDecoration(
                hintText: 'write here what you learned today',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: Colors.yellow,
                ),
                fillColor: Colors.white38,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.amber.shade200,
                    width: 1.0,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              cursorColor: Colors.black,
            ),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  if (titleInput == '') {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Hint'),
                          content:
                              const Text('You need to enter some text first'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('OK!'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    {
                      await FirebaseFirestore.instance.collection('mydays').add(
                        {
                          'title': titleInput,
                          'date': date,
                          'rating': rating,
                        },
                      );
                      widget.onSave();
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 48, 180, 247),
                ),
                child: const Text(
                  'save',
                ),
              ),
              const SizedBox(height: 20),
              Text('Selected date: ${date.year}/${date.month}/${date.day}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: date,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2100),
                  );
                  if (newDate == null) return;
                  setState(() {
                    date = newDate;
                  });
                },
                child: const Text('Select date'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
