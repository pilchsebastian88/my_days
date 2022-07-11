import 'package:flutter/material.dart';

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('MyDays'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: const [
                      Text('learn'),
                      Image(
                        image: AssetImage('images/brain.gif'),
                        height: 100,
                      ),
                    ],
                  ),
                  Column(
                    children: const [
                      Text('note'),
                      Image(
                        image: AssetImage('images/note.gif'),
                        height: 60,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: const [
                  Text('&rated'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
