import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMyDaysPageContent extends StatefulWidget {
  const AddMyDaysPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMyDaysPageContent> createState() => _AddMyDaysPageContentState();
}

class _AddMyDaysPageContentState extends State<AddMyDaysPageContent> {
  DateTime date = DateTime.now();
  var titleInput = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('add new day'),
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
                onPressed: () {
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
                    setState(
                      () {
                        FirebaseFirestore.instance.collection('mydays').add(
                          {
                            'title': titleInput,
                            'date': date,
                          },
                        );
                      },
                    );
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
              Text(
                  'The date you chose: ${date.year}/${date.month}/${date.day}'),
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
