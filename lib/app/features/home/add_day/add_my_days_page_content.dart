import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_days/app/features/home/add_day/cubit/add_day_cubit.dart';
import 'package:my_days/repositories/my_days_repository.dart';

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
  String? textData;
  DateTime? date;
  double? rating;
  bool? ratingUpdate;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddDayCubit(MyDaysRepository()),
      child: BlocBuilder<AddDayCubit, AddDayState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    'Select the date, then enter your text and tap save to add your new day',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 48, 180, 247)),
                  onPressed: () async {
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (newDate == null) return;
                    setState(() {
                      date = newDate;
                    });
                  },
                  child: Text('Jakaś data'),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    maxLines: null,
                    onChanged: (newValue) {
                      setState(() {
                        textData = newValue;
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
                const SizedBox(height: 10),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (textData == '') {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Hint'),
                                content: const Text(
                                    'You need to enter some text first'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text('OK!'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          {
                            context.read<AddDayCubit>().add(
                                  textData!,
                                  date!,
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
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
