import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyDays',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/home_page_background.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
