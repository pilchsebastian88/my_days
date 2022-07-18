import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_days/home/my_days/new_day_widget.dart';

class MyDaysPage extends StatefulWidget {
  const MyDaysPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyDaysPage> createState() => _MyDaysPageState();
}

class _MyDaysPageState extends State<MyDaysPage> {
  var currentIndex = 0;

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
      body: Builder(builder: (context) {
        if (currentIndex == 1) {
          return const AddMyDaysPageContent();
        }
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
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
                        },
                      );
                    },
                    key: ValueKey(document.id),
                    onDismissed: (_) {
                      FirebaseFirestore.instance
                          .collection('mydays')
                          .doc(document.id)
                          .delete();
                    },
                    child: NewDayWidget(
                      document['date'].toString(),
                      document['title'],
                    ),
                  ),
                ],
                const SizedBox(height: 500)
              ],
            );
          },
        );
      }),
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/bottom_navigation_bar_image.png'),
          ),
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Colors.grey.shade700,
          selectedItemColor: Colors.black,
          selectedFontSize: 15,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (newIndex) {
            setState(() {
              currentIndex = newIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.assignment,
              ),
              label: 'My Days',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              label: 'Add Day',
            ),
          ],
        ),
      ),
    );
  }
}

class AddMyDaysPageContent extends StatefulWidget {
  const AddMyDaysPageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<AddMyDaysPageContent> createState() => _AddMyDaysPageContentState();
}

class _AddMyDaysPageContentState extends State<AddMyDaysPageContent> {
  var titleInput = '';
  var dateInput = '';

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
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              cursorColor: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (newValue) {
                setState(() {
                  dateInput = newValue;
                });
              },
              decoration: InputDecoration(
                hintText: 'write here date yyyy.mm.dd',
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
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              cursorColor: Colors.black,
            ),
          ),
          Row(
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
                            'date': dateInput,
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
            ],
          ),
        ],
      ),
    );
  }
}
