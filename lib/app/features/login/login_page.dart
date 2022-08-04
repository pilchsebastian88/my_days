import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var errorMessage = '';
  var isCreatingAccount = false;

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'MyDays',
                style: GoogleFonts.dancingScript(fontSize: 80),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(isCreatingAccount == true ? 'register' : 'sign in'),
                    TextField(
                      controller: widget.emailController,
                      decoration: const InputDecoration(hintText: 'e-mail'),
                    ),
                    TextField(
                      controller: widget.passwordController,
                      decoration: const InputDecoration(hintText: 'password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Text(errorMessage),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 34, 164, 230),
                ),
                onPressed: () async {
                  if (isCreatingAccount == true) {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(
                        () {
                          errorMessage = error.toString();
                        },
                      );
                    }
                  } else {
                    try {
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: widget.emailController.text,
                        password: widget.passwordController.text,
                      );
                    } catch (error) {
                      setState(
                        () {
                          errorMessage = error.toString();
                        },
                      );
                    }
                  }
                },
                child: Text(
                  isCreatingAccount == true ? 'register' : 'sign in',
                ),
              ),
              const SizedBox(height: 20),
              if (isCreatingAccount == false) ...[
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    setState(() {
                      isCreatingAccount = true;
                    });
                  },
                  child: const Text(
                    'create account',
                  ),
                ),
              ],
              if (isCreatingAccount == true) ...[
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.amber),
                  onPressed: () {
                    setState(
                      () {
                        isCreatingAccount = false;
                      },
                    );
                  },
                  child: const Text(
                    'You have an account?',
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
