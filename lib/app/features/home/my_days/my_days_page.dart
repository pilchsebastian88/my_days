import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:my_days/app/features/home/add_day/add_my_days_page_content.dart';
import 'package:my_days/app/features/home/my_days/cubit/my_days_cubit.dart';
import 'package:my_days/app/models/new_day_model.dart';

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
      body: Builder(
        builder: (context) {
          if (currentIndex == 1) {
            return AddMyDaysPageContent(
              onSave: () {
                setState(() {
                  currentIndex = 0;
                });
              },
            );
          }
          return BlocProvider(
            create: (context) => MyDaysCubit()..start(),
            child: BlocBuilder<MyDaysCubit, MyDaysState>(
              builder: (context, state) {
                if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text('Somenthing went wrong ${state.errorMessage}'),
                  );
                }
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final newDayModels = state.documents;

                return ListView(
                  children: [
                    for (final newDayModel in newDayModels) ...[
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
                        key: ValueKey(newDayModel.id),
                        onDismissed: (_) {
                          context.read<MyDaysCubit>().remove(newDayModel.id);
                        },
                        child: NewDayWidget(newDayModel: newDayModel),
                      ),
                    ],
                    const SizedBox(height: 500)
                  ],
                );
              },
            ),
          );
        },
      ),
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

class NewDayWidget extends StatefulWidget {
  const NewDayWidget({
    required this.newDayModel,
    Key? key,
  }) : super(key: key);

  final NewDayModel newDayModel;

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
              DateFormat('yyyy-MM-dd').format(widget.newDayModel.date),
              style: GoogleFonts.dancingScript(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            widget.newDayModel.textData,
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
                    ignoreGestures: widget.newDayModel.ratingUpdate,
                    initialRating: widget.newDayModel.rating,
                    itemSize: 30,
                    minRating: 1,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.orange,
                    ),
                    onRatingUpdate: (rating) {
                      setState(
                        () {
                          FirebaseFirestore.instance
                              .collection('mydays')
                              .doc(widget.newDayModel.id)
                              .update(
                            {
                              'rating': rating,
                              'rating_update': true,
                            },
                          );
                          this.rating = rating;
                        },
                      );
                    },
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
