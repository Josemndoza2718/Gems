import 'dart:convert';

import 'package:appapijtest/main.dart';
import 'package:appapijtest/presentation/2/login/forgetscreen.dart';
import 'package:appapijtest/presentation/4/home/homescreen.dart';
import 'package:appapijtest/presentation/3/register/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Text _message = const Text("");
  bool _obscureText = true;
  FocusNode _focusNode = FocusNode();

  Future<void> guardarToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    // ignore: avoid_print
    print('Token guardado: $token');
  }

  Future<void> profileUserImage(String profileImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_image', profileImage);
    // ignore: avoid_print
    print('Imagen guardada: $profileImage');
  }

  Future<void> fullnameg(String fullname) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullname', fullname);
    // ignore: avoid_print
    print('Nombre guardado: $fullname');
  }

  Future<String?> obtenerToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("Token Obtenido $token");
    return prefs.getString('token');
  }

  Future<void> login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;
    

    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('${globalVariable}/login'),
      headers: headers,
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final accessToken = jsonResponse['auth_credentials']['access_token'];
      final fullname = jsonResponse['user']['fullname'];
      final profileImage = jsonResponse['user']['profile_image'];

      setState(
        () {
          _message = const Text(
            "Inicio de sesión exitoso",
            style: TextStyle(color: Colors.green),
          );
        },
      );

      await guardarToken(accessToken); // Guardar el token en SharedPreferences
      await fullnameg(fullname); // Guardar el nombre en SharedPreferences
      await profileUserImage(profileImage);

      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );

      // ignore: avoid_print
      print(response.body);
    }else if (response.statusCode == 401) {
      //ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atención'),
          content: const Text(
              'Usuario o Contraseña invalidos, por favor intentelo de nuevo'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      );
    } else {
      setState(() {
        _message = Text(
          'Error en el inicio de sesión: ${response.statusCode}',
          style: const TextStyle(color: Colors.red),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    obtenerToken().then((token) {
      if (token != null) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 15),
                Image.asset(
                  "assets/images/logo.png",
                  height: 150.5,
                  width: 130.1,
                ),
                const SizedBox(height: 30),
                const Text(
                  "Login",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 0, bottom: 10),
                  child: Text(
                    "sign in to continue",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        //height: 400,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 41, 41, 41),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                      ),
                      LoginTextField(),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "¿Don't have an account?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "sign up",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  LoginTextField() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.people_alt,
                color: Colors.white,
              ),
              Padding(
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              focusNode: _focusNode,
              controller: _usernameController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                hintText: "Margarita Perez",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(30.0), // Radio de los bordes
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 4,
                  ), // Color del borde cuando el campo está enfocado
                ),
              ),
              onChanged:  (value) {
            // Filtrar los espacios en blanco y actualizar el texto del TextField
            final newValue = value.replaceAll(' ', '');
            if (newValue != value) {
              _usernameController.value = TextEditingValue(
                text: newValue,
                selection: TextSelection.collapsed(offset: newValue.length),
              );
            }
          },
            ),
          ),
          const SizedBox(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock,
                color: Colors.white,
              ),
              Padding(
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
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              obscureText: _obscureText,
              controller: _passwordController,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                hintText: "*********",
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText =
                          !_obscureText; // Cambia el estado de ocultar/mostrar texto
                    });
                  },
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(10.0), // Radio de los bordes
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(
                      color: Colors.blue,
                    width: 4,), // Color del borde cuando el campo está enfocado
                ),
                // icon:
                //     const Icon(Icons.lock, color: Colors.white),
              ),
              onChanged: (value) {
            // Filtrar los espacios en blanco y actualizar el texto del TextField
            final newValue = value.replaceAll(' ', '');
            if (newValue != value) {
              _passwordController.value = TextEditingValue(
                text: newValue,
                selection: TextSelection.collapsed(offset: newValue.length),
              );
            }
          },

            ),
          ),
          Align(
            alignment: const Alignment(0.7, 0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ForgetScreen(),
                  ),
                );
              },
              child: const Text(
                "forget password",
                style: TextStyle(
                    color: Colors.white, decoration: TextDecoration.underline),
              ),
            ),
          ),
          const SizedBox(height: 40.0),
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
            onPressed: login,
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 35, right: 35, bottom: 15, top: 15),
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: _message,
          ),
        ],
      ),
    );
  }
}
