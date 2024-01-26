import 'dart:convert';
//import 'dart:ffi';

import 'package:appapijtest/infrastructure/models/gemas_all.dart';
import 'package:appapijtest/main.dart';
import 'package:appapijtest/presentation/4/home/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GemstoneDetailsScreen extends StatefulWidget {
  final GemAll gemstone;

  GemstoneDetailsScreen.PropGemsPage({required this.gemstone});

  @override
  State<GemstoneDetailsScreen> createState() => _GemstoneDetailsScreenState();
}


/// GUARDAR COMPRA
Future<void> saveBuy(double buy) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('quantity', buy);
  // ignore: avoid_print
  print('Compra guardada: $buy');
}

///

class SharedPreferencesUtilsColor {
  static Future<String?> getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("color"));
    return prefs.getString('color');
  }
}

class SharedPreferencesUtilsfullClarity {
  static Future<int?> getClarity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("clarity"));
    return prefs.getInt("clarity");
  }
}

class _GemstoneDetailsScreenState extends State<GemstoneDetailsScreen> {
  final TextEditingController sizeController = TextEditingController();

  int? claritySelect;
  String? colorSelect;
  bool available = true;
  String gemType = "DIAMOND";

  int contador = 0;
  double compra = 0;
  int res = 0;

  @override
  void initState() {
    super.initState();
    loadColorSelect();
    loadClaritySelecet();
  }

  Future<void> loadClaritySelecet() async {
    int? clarity = await SharedPreferencesUtilsfullClarity.getClarity();
    setState(() {
      claritySelect = clarity;
    });
  }

  Future<void> loadColorSelect() async {
    final color = await SharedPreferencesUtilsColor.getColor();
    setState(() {
      colorSelect = color;
    });
  }

  Future<void> buygems() async {
    final idgem = widget.gemstone.id;
    //final quantitygems = widget.gemstone.quantity;

    var headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('${globalVariable}/seller/gem'),
      headers: headers,
      body: jsonEncode({
        'id': idgem,
        'quantity': contador,
      }),
    );

    if (response.statusCode == 201) {

      if (contador > 0) {
        compra = widget.gemstone.price * contador;
        showmessagebuy();
        //print("Guardar compra: $compra");
      } else {
        // Manejar el caso donde el contador es 0
        showmessage();
      }
      // ignore: avoid_print
      print(response.body);
    }
  }

  void incrementCounter() {
    setState(() {
      if (contador >= 0) {
        contador++;
      }
    });
  }

  void decrementCounter() {
    setState(() {
      if (contador > 0) {
        contador--;
      }
    });
  }

  void showmessagebuy() {
    setState(() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
              child: const Text("Finalizar"),
            )
          ],
          title: const Text("Compra Exitosa"),
          contentPadding: const EdgeInsets.all(20),
          content: Text(
              "Su compra de ${widget.gemstone.gemType} por el monto de $compra se ha procesado de manera exitosa"),
        ),
      );
    });
  }

  void showmessage() {
    setState(() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Close"),
                  )
                ],
                title: const Text("Error de compra"),
                contentPadding: const EdgeInsets.all(20),
                content:
                    const Text("No ingreso la cantidad del producto a comprar"),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Image.network(
                      widget.gemstone.image == widget.gemstone.gemType
                          ? "https://s1.abcstatics.com/media/summum/2018/10/31/Diamantes-k7bB--1248x698@abc.jpg"
                          : widget.gemstone.image,
                      scale: 1.0,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  widget.gemstone.gemType,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w900),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "\$${widget.gemstone.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "${widget.gemstone.quantity} unidades",
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Column(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Color",
                      style: TextStyle(fontSize: 25),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: colorSelect == "D"
                      //     ? Colors.amber
                      //     : Colors.grey,
                      //   ),
                      //   child: Text("$colorSelect", style: TextStyle(fontSize: 30, color: Colors.black),),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       shape: BoxShape.circle,
                      //       color: colorSelect == "E"
                      //       ? const Color.fromARGB(255, 9, 94, 153)
                      //       : Colors.grey
                      //     ),
                      //     child: Text("$colorSelect", style: TextStyle(fontSize: 30, color: Colors.white),),
                      //   ),
                      // ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     color: colorSelect == "G"
                      //     ? Color.fromARGB(255, 82, 113, 255)
                      //     : Colors.grey,
                      //   ),
                      //   child: Text("$colorSelect", style: TextStyle(fontSize: 30, color: Colors.black),),
                      // ),
                      Icon(Icons.circle, color: Colors.amber, size: 32,),
                      Icon(Icons.circle, color: Color.fromARGB(255, 9, 94, 153), size: 32,),
                      Icon(Icons.circle, color: Color.fromARGB(255, 82, 113, 255), size: 32,),

                      // Padding(
                      //   padding: const EdgeInsets.all(0.0),
                      //   child: IconButton(
                      //     icon: const Icon(Icons.circle),
                      //     iconSize: 32,
                      //     color: Colors.amber,
                      //     onPressed: () {null;},
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(0.0),
                      //   child: IconButton(
                      //     icon: const Icon(Icons.circle),
                      //     iconSize: 32,
                      //     color: const Color.fromARGB(255, 9, 94, 153),
                      //     onPressed: () {},
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(0.0),
                      //   child: IconButton(
                      //     icon: const Icon(Icons.circle),
                      //     iconSize: 32,
                      //     color: const Color.fromARGB(255, 82, 113, 255),
                      //     onPressed: () {},
                      //   ),
                      // ),
                    ],
                  ),
                ]),
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Clarity",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                shape: const MaterialStatePropertyAll(
                                    CircleBorder()),
                                backgroundColor: const MaterialStatePropertyAll(
                                    Color.fromARGB(255, 0, 0, 0)),
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(EdgeInsets.zero),
                              ),
                              child: const Text(
                                "SI",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(CircleBorder()),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 0, 0, 0)),
                              ),
                              child: const Text(
                                "VS",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: const ButtonStyle(
                                shape: MaterialStatePropertyAll(CircleBorder()),
                                backgroundColor: MaterialStatePropertyAll(
                                    Color.fromARGB(255, 0, 0, 0)),
                              ),
                              child: const Text(
                                "FL",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            /*CONTADOR Y CARRITO*/
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*CONTADOR */
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: decrementCounter,
                    ),
                    Text(
                      contador.toString(),
                      style: const TextStyle(fontSize: 48),
                    ),
                    Transform.rotate(
                      angle: 3.14,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios),
                        onPressed: incrementCounter,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 40),
                ElevatedButton(
                  onPressed: () {
                    if (contador <= widget.gemstone.quantity) {
                      buygems();
                    } else if (contador > widget.gemstone.quantity) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          actions: [
                            TextButton(
                              onPressed: () {
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cerrar"),
                            )
                          ],
                          title: const Text("¡Alerta!"),
                          contentPadding: const EdgeInsets.all(20),
                          content: const Text(
                              "La cantidad de comprar debe coincidir con la que hay disponibles"),
                        ),
                      );
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const BuyGems(),
                    //   ),
                    // );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 0, 0, 0)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 25.0, bottom: 25),
                    child: Text(
                      "Add To Chart",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            )
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: PhysicalModel(
            //     borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            //     color: Colors.white,
            //     elevation: 20.0,
            //     shadowColor: Colors.black,
            //     child: Container(
            //       alignment: Alignment.topLeft,
            //       width: 360,
            //       decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(20.0)),
            //       ),
            //       child: Column(
            //         children: [
            //           const Padding(
            //             padding:
            //                 EdgeInsets.only(top: 10.0, left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'CARACTERÍSTICAS:',
            //                 style: TextStyle(
            //                   fontSize: 16.0,
            //                   fontWeight: FontWeight.w900,
            //                   color: Color.fromARGB(255, 14, 0, 139),
            //                 ),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Gem Type: ${gemstone.gemType}',
            //                 style: const TextStyle(fontSize: 16.0),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Price: \$${gemstone.price.toStringAsFixed(2)}',
            //                 style: const TextStyle(fontSize: 16.0),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Size: ${gemstone.size}',
            //                 style: const TextStyle(fontSize: 16.0),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Color: ${gemstone.color}',
            //                 style: const TextStyle(fontSize: 16.0),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
            //             child: Align(
            //               alignment: Alignment.topLeft,
            //               child: Text(
            //                 'Clarity: ${gemstone.clarity}',
            //                 style: const TextStyle(fontSize: 16.0),
            //                 //textAlign: TextAlign.left,
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
