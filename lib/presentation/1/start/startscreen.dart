import 'package:appapijtest/presentation/2/login/loginscreen.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 60),
            Image.asset(
              "assets/images/logo.png",
              height: 150.5,
              width: 130.1,
            ),
            const SizedBox(height: 100),
            const Text(
              "Welcome to",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "Shape Inc.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 100),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    //height: 385,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 41, 41, 41),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(80),
                          topRight: Radius.circular(80)),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                alignment: Alignment.center,
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 70, 70, 70))),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  left: 35, right: 35, bottom: 15, top: 15),
                              child: Text(
                                "Let's Start",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Shine with shape, sparkle with grace!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
