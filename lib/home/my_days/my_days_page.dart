import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_days/home/my_days/add_my_days_page_content.dart';
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
