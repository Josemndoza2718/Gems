import 'package:flutter/material.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    FocusNode _focusNode = FocusNode();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Image.asset(
              "assets/images/logo_pas.png",
              height: 250,
              width: 250,
            ),
            const SizedBox(height: 50),
            const Text(
              textAlign: TextAlign.center,
              "Forgot\nPassword",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              textAlign: TextAlign.center,
              "New Password",
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/images/logo_email.png",
                  height: 50,
                  width: 50,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints(minWidth: 200, maxWidth: 250),
                  child: TextField(
                    focusNode: _focusNode,
                    controller: _emailController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      hintText: "MargaritaP_2024@gmail.com",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(30.0), // Radio de los bordes
                        //borderSide: const BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                          width: 3,
                          color: Colors.blue,
                        ), // Color del borde cuando el campo está enfocado
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 0, 191, 99),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    padding: const MaterialStatePropertyAll(
                      EdgeInsets.only(
                        left: 50,
                        right: 50,
                        bottom: 13,
                        top: 13,
                      ),
                    )),
                child: const Text(
                  "SEND",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
