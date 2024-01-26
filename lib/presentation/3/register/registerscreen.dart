import 'dart:convert';

import 'package:appapijtest/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool _obscureText = true;
  bool _obscureText2 = true;

  Future<void> createUser() async {
    var url = Uri.parse('${globalVariable}/registration');
    var body = {
      'username': usernameController.text,
      'password': passwordController.text,
      'password2': confirmPasswordController.text,
      'email': emailController.text,
    };

    var headers = {'Content-Type': 'application/json'};
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Éxito: el usuario se creó correctamente
      Fluttertoast.showToast(
        msg: 'Usuario creado',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    } else {
      // Error al crear el usuario
      Fluttertoast.showToast(
        msg: 'Error al crear el usuario',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 80,
                  width: 60,
                ),
              ),
            ),
            const Text(
              "Sing up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w500),
            ),
            const Text(
              "create new account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.w500),
            ),
            Image.asset(
              "assets/images/userlogo.png",
              height: 150.5,
              width: 100,
            ),
            //const SizedBox(height: 5),
            RegisterContent(),
          ],
        ),
      ),
    );
  }

  RegisterContent() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 620,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 41, 41, 41),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  /*
                  ##############################
                  #     START TEXTFIELD #1     #
                  ##############################
                  */
                  const Align(
                    alignment: Alignment(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "full name",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        hintText: "Margarita Perez",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ), // Radio de los bordes
                          //borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 3.0,
                            color: Colors.blue,
                          ), // Color del borde cuando el campo está enfocado
                        ),
                      ),
                    ),
                  ),
                  /*
                  ##############################
                  #     END TEXTFIELD #1       #
                  ##############################
                  */
                  const SizedBox(height: 20),
                  /*
                  ##############################
                  #     START TEXTFIELD #2     #
                  ##############################
                  */
                  const Align(
                    alignment: Alignment(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "user name",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        hintText: "@MargaritaPerez",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30.0,
                          ), // Radio de los bordes
                          //borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: const BorderSide(
                            width: 3.0,
                            color: Colors.blue,
                          ), // Color del borde cuando el campo está enfocado
                        ),
                      ),
                    ),
                  ),
                  /*
                  ##############################
                  #     END TEXTFIELD #2       #
                  ##############################
                  */
                  const SizedBox(height: 20),
                  /*
                  ##############################
                  #     START TEXTFIELD #3     #
                  ##############################
                  */
                  const Align(
                    alignment: Alignment(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "email",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        hintText: "MargaritaP_2024@gmail.com",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Radio de los bordes
                          //borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                  /*
                  ##############################
                  #     END TEXTFIELD #3       #
                  ##############################
                  */
                  const SizedBox(height: 20),
                  /*
                  ##############################
                  #     START TEXTFIELD #4     #
                  ##############################
                  */
                  const Align(
                    alignment: Alignment(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "password",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText =
                                  !_obscureText; // Cambia el estado de ocultar/mostrar texto
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        hintText: "*********",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Radio de los bordes
                          //borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                  /*
                  ##############################
                  #     END TEXTFIELD #4       #
                  ##############################
                  */
                  const SizedBox(height: 20),
                  /*
                  ##############################
                  #     START TEXTFIELD #5     #
                  ##############################
                  */
                  const Align(
                    alignment: Alignment(-0.7, 0),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "verify password",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      obscureText: _obscureText2,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText2 =
                                  !_obscureText2; // Cambia el estado de ocultar/mostrar texto
                            });
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 24,
                        ),
                        hintText: "*********",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              30.0), // Radio de los bordes
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide:
                              const BorderSide(color: Colors.transparent),
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
                  /*
                  ##############################
                  #     END TEXTFIELD #5       #
                  ##############################
                  */
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 70, 70, 70)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    onPressed: createUser,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          left: 75, right: 75, bottom: 10, top: 10),
                      child: Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
