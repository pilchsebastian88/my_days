import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_days/home/my_days/my_days_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    required this.email,
    Key? key,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'MyDays',
                style: GoogleFonts.dancingScript(fontSize: 80),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'learn',
                        style: GoogleFonts.noticiaText(fontSize: 30),
                      ),
                      const Image(
                        image: AssetImage('images/brain.gif'),
                        height: 100,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'note',
                        style: GoogleFonts.dancingScript(fontSize: 50),
                      ),
                      const Image(
                        image: AssetImage('images/note.gif'),
                        height: 60,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    '&rate',
                    style: GoogleFonts.noticiaText(fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 30,
                      ),
                      Icon(
                        Icons.star_half,
                        color: Colors.amber,
                        size: 30,
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 48, 180, 247),
                    ),
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('sign out'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 48, 180, 247),
                        onPrimary: Colors.yellow),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const MyDaysPage(),
                        ),
                      );
                    },
                    child: const Text('get started'),
                  ),
                ],
              ),
              Text('You are logged in as $email')
            ],
          ),
        ),
      ),
    );
  }
}
