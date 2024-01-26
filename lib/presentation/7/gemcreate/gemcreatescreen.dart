import 'dart:convert';

import 'package:appapijtest/main.dart';
import 'package:appapijtest/presentation/4/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GemCreateScreen extends StatefulWidget {
  final String accessToken;

  const GemCreateScreen({required this.accessToken});

  @override
  State<GemCreateScreen> createState() => _GemCreateScreenState();
}

Future<void> savecolor(String colorSelect) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('color', colorSelect);
  // ignore: avoid_print
  print('Color guardado: $colorSelect');
}

Future<void> saveclarity(int claritySelect) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('clarity', claritySelect);
  // ignore: avoid_print
  print('Clarity guardado: $claritySelect');
}

class SharedPreferencesUtils {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    return prefs.getString('token');
  }
}

class _GemCreateScreenState extends State<GemCreateScreen> {
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController quantity = TextEditingController();

  int clarityController = 1;
  String colorController = "D";
  bool available = true;
  String gemType = "DIAMOND";

  

  Future<void> createGem() async {
    String? token = await SharedPreferencesUtils.getToken();

    final response = await http.post(
      Uri.parse("${globalVariable}/gems/create"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "gem_pr": {
          "size": sizeController.text,
          "clarity": clarityController,
          "color": colorController
        },
        "gem": {
          "quantity": quantity.text,
          "available": available,
          "gem_type": gemType,
        }
      }),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final claritySelect = jsonResponse["props"]["clarity"];
      final colorSelect = jsonResponse["props"]["color"];

      // La gema se creó exitosamente

      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Gem created successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      await savecolor(colorSelect); // Guardar el token en SharedPreferences
      await saveclarity(claritySelect); // Guardar el token en SharedPreferences
    } else if (response.statusCode == 403) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atención'),
          content: const Text('Fallo en la comunicación'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                print(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 422) {
      // ignore: use_build_context_synchronously
      // showDialog(
      //   context: context,
      //   builder: (context) => AlertDialog(
      //     title: const Text('Atención'),
      //     content: const Text('Problema con la sintaxis de una solicitud'),
      //     actions: [
      //       TextButton(
      //         onPressed: () => Navigator.pop(context),
      //         child: const Text('OK'),
      //       ),
      //     ],
      //   ),
      // );
    } else if (response.statusCode == 400) {
      //ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atención'),
          content: const Text('Datos enviados invalidos'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (response.statusCode == 401) {
      //ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Atención'),
          content: const Text(
              'No puedes crear un gema con datos vacios, por favor rellena los campos'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Hubo un error al crear la gema
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content:
              Text('Failed to create gem. Status code: ${response.statusCode}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    createGem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 260,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(150),
                    bottomRight: Radius.circular(150)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 50),
                      child: Image.asset(
                        "assets/images/gema.png",
                        height: 300,
                        width: 300,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            "Color Option",
                            style: TextStyle(fontSize: 20),
                          ),
                          Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: colorController == 'D'
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    colorController = "D";
                                  });
                              
                                  print(colorController);
                                },
                                child: null,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: colorController == 'E'
                                      ? const Color.fromARGB(255, 9, 94, 153)
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    colorController = "E";
                                  });
                              
                                  print(colorController);
                                },
                                child: null,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  backgroundColor: colorController == 'G'
                                      ? const Color.fromARGB(255, 82, 113, 255)
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    colorController = "G";
                                  });
                              
                                  print(colorController);
                                },
                                child: null,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: IconButton(
                              //     icon: const Icon(Icons.circle),
                              //     iconSize: 32,
                              //     color: const Color.fromARGB(255, 9, 94, 153),
                              //     onPressed: () {
                              //       colorController = "E";
                              //       print(colorController);
                              //     },
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8.0),
                              //   child: IconButton(
                              //     icon: const Icon(Icons.circle),
                              //     iconSize: 32,
                              //     color:
                              //         const Color.fromARGB(255, 82, 113, 255),
                              //     onPressed: () {
                              //       colorController = "G";
                              //       print(colorController);
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 30),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Cantidad",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 50,
                            width: 90,
                            child: Column(children: [
                              TextField(
                                keyboardType: TextInputType
                                    .number, // Establece el tipo de teclado como numérico
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]'))
                                ],
                                textAlign: TextAlign.center,
                                controller: quantity,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Size",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            color: Colors.transparent,
                            height: 50,
                            width: 90,
                            child: Column(children: [
                              TextField(
                                keyboardType: TextInputType
                                    .number, // Establece el tipo de teclado como numérico
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0.0-9.0]'))
                                ],
                                textAlign: TextAlign.center,
                                controller: sizeController,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Clarity",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: clarityController == 1
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    clarityController = 1;
                                  });
                              
                                  print(colorController);
                                },
                                child: const Text(
                                    "SI",
                                    style: TextStyle(color: Colors.black),
                                  ),
                              ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: clarityController == 2
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      clarityController = 2;
                                    });
                                                              
                                    print(colorController);
                                  },
                                  child: const Text(
                                      "VS",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                                              ),
                                ),
                                ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: clarityController == 3
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    clarityController = 3;
                                  });
                              
                                  print(colorController);
                                },
                                child: const Text(
                                    "FL",
                                    style: TextStyle(color: Colors.black),
                                  ),
                              ),
                              ],
                            )
                          ]),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 60.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DropdownButton<String>(
                        value: gemType,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 32),
                        onChanged: (String? newValue) {
                          setState(() {
                            gemType = newValue!;
                          });
                          print(gemType);
                        },
                        items: <String>[
                          'DIAMOND',
                          'RUBY',
                          'EMERALD',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const Text(
                        "\$\$\$",
                        style: TextStyle(
                            fontSize: 52,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 9, 94, 153)),
                      )
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 136, 168, 231))),
                    onPressed: createGem,
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 8.0, bottom: 8.0, right: 40, left: 40),
                      child: Text(
                        'CREATE GEM',
                        style: TextStyle(fontSize: 18),
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
