import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('mydays').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Somenthing went wrong ${snapshot.hasData}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = snapshot.data!.docs;
          return ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: widget.controller,
                      decoration: InputDecoration(
                        hintText:
                            'write here what you learned today and tap "save"',
                        hintStyle: const TextStyle(
                          fontSize: 11,
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
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.5),
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Focus.of(context).requestFocus(FocusNode());
                      if (widget.controller.text.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Hint'),
                              content: const Text(
                                  'You need to enter some text first'),
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
                                'title': widget.controller.text,
                                'date': double.nan
                              },
                            );
                            widget.controller.clear();
                            FocusScope.of(context).unfocus();
                          },
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 48, 180, 247)),
                    child: const Text(
                      'save',
                    ),
                  ),
                ],
              ),
              for (final document in documents) ...[
                Dismissible(
                  confirmDismiss: (DismissDirection direction) async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm action!'),
                            content: const Text('You want delete YourDay?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                child: const Text('Delete'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancel'),
                              ),
                            ],
                          );
                        });
                  },
                  key: ValueKey(document.id),
                  onDismissed: (_) {
                    FirebaseFirestore.instance
                        .collection('mydays')
                        .doc(document.id)
                        .delete();
                  },
                  child: NewDayWidget(
                    document['title'],
                    document['date'],
                  ),
                ),
              ],
              const SizedBox(height: 500)
            ],
          );
        },
      ),
      bottomSheet: Image.asset(
        'images/bottomsheet_image.png',
      ),
    );
  }
}
