import 'package:appapijtest/presentation/2/login/loginscreen.dart';
import 'package:appapijtest/presentation/5/getallgems/getallgemscreen.dart';
import 'package:appapijtest/presentation/6/props/buygems.dart';
import 'package:appapijtest/presentation/7/gemcreate/gemcreatescreen.dart';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  //final String profileImage;
  //HomeScreen({required this.profileImage});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class SharedPreferencesUtilsimg {
  static Future<String?> getuserimage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("profile_image"));
    return prefs.getString('profile_image');
  }
}

class SharedPreferencesUtilsfull {
  static Future<String?> getfullname() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("fullname"));
    return prefs.getString('fullname');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String? profileImage;
  String? fullname;

  @override
  void initState() {
    super.initState();
    loadFullName();
    loadUserImage();
  }

  Future<void> loadFullName() async {
    final name = await SharedPreferencesUtilsfull.getfullname();
    setState(() {
      fullname = name;
    });
  }

  Future<void> loadUserImage() async {
    final image = await SharedPreferencesUtilsimg.getuserimage();
    setState(() {
      profileImage = image;
    });
  }

  String accessToken = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: ListView(
        children: [
          Card(
            color: Color.fromARGB(255, 82, 113, 255),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(50), // Radio de los bordes deseados
            ),
            elevation: 20.0,
            //margin: const EdgeInsets.all(20),
            child: Container(
              alignment: Alignment.center,
              //padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 82, 113, 255),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80),
                ),
              ),
              width: double.infinity, // Ancho máximo disponible
              height: 180, // Altura deseada de la tarjeta
              child: Column(
                children: [
                  const Divider(height: 40, color: Colors.transparent),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ClipOval(
                        child: Image.network(
                          profileImage ??
                              'https://res.cloudinary.com/brainlypf/image/upload/v1704917292/gemstone-profiles/uirvrhl6sgfmkbvutjuv.png',
                          height: 100,
                          width: 100,
                          //scale: 0.1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Text(
                        '$fullname',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.keyboard_return_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Card(
          //   margin: const EdgeInsets.all(20),
          //   child: Container(
          //     padding: const EdgeInsets.all(20),
          //     color: Colors.white,
          //     width: double.infinity, // Ancho máximo disponible
          //     height: 215, // Altura deseada de la tarjeta
          //     child: Column(
          //       children: [
          //         const Align(
          //           alignment: Alignment.topLeft,
          //           child: Text(
          //             "Bienvenido",
          //             style: TextStyle(
          //               fontSize: 18,
          //               color: Colors.white,
          //             ),
          //           ),
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Align(
          //               alignment: Alignment.topLeft,
          //               child: Text(
          //                 '$fullname',
          //                 style: const TextStyle(
          //                   fontSize: 28,
          //                   fontWeight: FontWeight.w700,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //             ClipOval(
          //               child: Image.network(
          //                 profileImage ?? 'https://s1.abcstatics.com/media/summum/2018/10/31/Diamantes-k7bB--1248x698@abc.jpg',
          //                 height: 100,
          //                 width: 100,
          //                 scale: 0.1,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                hintText: "Search",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(80.0), // Radio de los bordes
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 30.0,
              top: 10,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Quiero...",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              /*BOTON COMPRAR GEMAS */
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetAllGemsScreen(
                        accessToken: accessToken,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                      Color.fromARGB(255, 82, 113, 255),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(100, 150),
                    ), // Establece el tamaño mínimo del botón
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10),
                    ) // Establece el padding interno del botón
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        "assets/images/cart.png",
                        height: 70,
                        width: 70,
                      ), // Icono en la parte superior
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Comprar \ngema',
                        style: TextStyle(fontSize: 18),
                      ),
                    ), // Texto en la parte inferior
                  ],
                ),
              ),
              /*BOTON VER MIS COMPRAS */
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BuyGems(),
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 82, 113, 255)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(100, 150),
                    ), // Establece el tamaño mínimo del botón
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10),
                    ) // Establece el padding interno del botón
                    ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                        "assets/images/carto.png",
                        height: 70,
                        width: 70,
                      ), // Icono en la parte superior
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Ver mis \ncompras',
                        style: TextStyle(fontSize: 18),
                      ),
                    ), // Texto en la parte inferior
                  ],
                ),
              ),
              /*BOTON CREAR GEMAS */
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GemCreateScreen(
                        accessToken: accessToken,
                      ),
                    ),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 82, 113, 255)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    )),
                    minimumSize: MaterialStateProperty.all<Size>(
                      const Size(100, 150),
                    ), // Establece el tamaño mínimo del botón
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.all(10),
                    ) // Establece el padding interno del botón
                    ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.diamond,
                      size: 70,
                    ), // Icono en la parte superior
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Crear \ngemas',
                        style: TextStyle(fontSize: 18),
                      ),
                    ), // Texto en la parte inferior
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     // Acción cuando se presiona el botón
              //   },
              //   style: ButtonStyle(
              //       backgroundColor: const MaterialStatePropertyAll(
              //           Color.fromARGB(255, 82, 113, 255)),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30.0),
              //       )),
              //       minimumSize: MaterialStateProperty.all<Size>(
              //         const Size(130, 150),
              //       ), // Establece el tamaño mínimo del botón
              //       padding: MaterialStateProperty.all<EdgeInsets>(
              //         const EdgeInsets.all(10),
              //       ) // Establece el padding interno del botón
              //       ),
              //   child: const Column(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Icon(
              //         Icons.outbond,
              //         size: 70,
              //       ), // Icono en la parte superior
              //       Padding(
              //         padding: EdgeInsets.all(8.0),
              //         child: Text(
              //           'Cerrar \nsesión',
              //           style: TextStyle(fontSize: 18),
              //         ),
              //       ), // Texto en la parte inferior
              //     ],
              //   ),
              // )
            ],
          ),
          const SizedBox(height: 50),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 375,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 34.0,
                      top: 34.0,
                      bottom: 34.0,
                    ),
                    child: Text(
                      "Carrito de Compras",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(width: 20,),
                    Image.asset(
                        "assets/images/logo_cart.png",
                        height: 70,
                        width: 70,
                      ),

                      const SizedBox(width: 5,),
                    const Column(
                      children: [
                        Text(
                          "Your shopping cart is empty.",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Check the gem catalog to view \nthem here...",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,)
                  ],
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromARGB(255, 0, 0, 0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 0, right: 0, bottom: 15, top: 15),
                    child: Text(
                      'Go to Checkout',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      // body: FutureBuilder<void>(
      //   future: loadUserImage(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // La imagen se ha cargado correctamente
      //       return CachedNetworkImage(
      //         imageUrl: profileImage.toString(),
      //         placeholder: (context, url) => const CircularProgressIndicator(),
      //         errorWidget: (context, url, error) => const Icon(Icons.error),
      //       );
      //     } else if (snapshot.hasError) {
      //       // Ocurrió un error al cargar la imagen
      //       return const Text('Error al cargar la imagen');
      //     } else {
      //       // Muestra un indicador de carga mientras se carga la imagen
      //       //return CircularProgressIndicator();
      //       return ListView(
      //         children: [
      //           const SizedBox(
      //             height: 40,
      //           ),
      //           Card(
      //             margin: const EdgeInsets.all(20),
      //             child: Container(
      //               padding: const EdgeInsets.all(20),
      //               color: Colors.black,
      //               width: double.infinity, // Ancho máximo disponible
      //               height: 215, // Altura deseada de la tarjeta
      //               child: Column(
      //                 children: [
      //                   const Align(
      //                     alignment: Alignment.topLeft,
      //                     child: Text(
      //                       "Bienvenido",
      //                       style: TextStyle(
      //                         fontSize: 18,
      //                         color: Colors.white,
      //                       ),
      //                     ),
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Align(
      //                         alignment: Alignment.topLeft,
      //                         child: Text(
      //                           '$fullname',
      //                           style: const TextStyle(
      //                             fontSize: 28,
      //                             fontWeight: FontWeight.w700,
      //                             color: Colors.white,
      //                           ),
      //                         ),
      //                       ),
      //                       // ClipOval(
      //                       //   child: CachedNetworkImage(
      //                       //     width: 100,
      //                       //     height: 100,
      //                       //     imageUrl: profileImage ??
      //                       //         'https://res.cloudinary.com/brainlypf/image/upload/v1704917292/gemstone-profiles/uirvrhl6sgfmkbvutjuv.png',
      //                       //     placeholder: (context, url) =>
      //                       //         const CircularProgressIndicator(),
      //                       //     errorWidget: (context, url, error) =>
      //                       //         const Icon(Icons.error),
      //                       //     fit: BoxFit.cover,
      //                       //   ),
      //                       // ),
      //                       ClipOval(
      //                         child: Image.network(
      //                           profileImage ??
      //                               'https://s1.abcstatics.com/media/summum/2018/10/31/Diamantes-k7bB--1248x698@abc.jpg',
      //                           height: 100,
      //                           width: 100,
      //                           scale: 0.1,
      //                           fit: BoxFit.cover,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.all(20.0),
      //             child: TextField(
      //               decoration: InputDecoration(
      //                 prefixIcon: const Icon(Icons.search),
      //                 contentPadding: const EdgeInsets.symmetric(
      //                   vertical: 16,
      //                   horizontal: 24,
      //                 ),
      //                 hintText: "Search",
      //                 filled: true,
      //                 fillColor: Colors.white,
      //                 border: OutlineInputBorder(
      //                   borderRadius:
      //                       BorderRadius.circular(80.0), // Radio de los bordes
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const Padding(
      //             padding: EdgeInsets.only(
      //               left: 30.0,
      //               top: 10,
      //             ),
      //             child: Align(
      //               alignment: Alignment.topLeft,
      //               child: Text(
      //                 "Quiero...",
      //                 style: TextStyle(
      //                   fontSize: 24,
      //                   color: Colors.white,
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(height: 30),
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               /*BOTON COMPRAR GEMAS */
      //               ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => GetAllGemsScreen(
      //                         accessToken: accessToken,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 style: ButtonStyle(
      //                     backgroundColor: const MaterialStatePropertyAll(
      //                       Color.fromARGB(255, 82, 113, 255),
      //                     ),
      //                     shape:
      //                         MaterialStateProperty.all<RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(30.0),
      //                     )),
      //                     minimumSize: MaterialStateProperty.all<Size>(
      //                       const Size(100, 150),
      //                     ), // Establece el tamaño mínimo del botón
      //                     padding: MaterialStateProperty.all<EdgeInsets>(
      //                       const EdgeInsets.all(10),
      //                     ) // Establece el padding interno del botón
      //                     ),
      //                 child: const Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(
      //                       Icons.shopping_cart,
      //                       size: 70,
      //                     ), // Icono en la parte superior
      //                     Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: Text(
      //                         'Comprar \ngema',
      //                         style: TextStyle(fontSize: 18),
      //                       ),
      //                     ), // Texto en la parte inferior
      //                   ],
      //                 ),
      //               ),
      //               /*BOTON VER MIS COMPRAS */
      //               ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => const BuyGems(),
      //                     ),
      //                   );
      //                 },
      //                 style: ButtonStyle(
      //                     backgroundColor: const MaterialStatePropertyAll(
      //                         Color.fromARGB(255, 82, 113, 255)),
      //                     shape:
      //                         MaterialStateProperty.all<RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(30.0),
      //                     )),
      //                     minimumSize: MaterialStateProperty.all<Size>(
      //                       const Size(100, 150),
      //                     ), // Establece el tamaño mínimo del botón
      //                     padding: MaterialStateProperty.all<EdgeInsets>(
      //                       const EdgeInsets.all(10),
      //                     ) // Establece el padding interno del botón
      //                     ),
      //                 child: const Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(
      //                       Icons.shopping_cart_checkout,
      //                       size: 70,
      //                     ), // Icono en la parte superior
      //                     Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: Text(
      //                         'Ver mis \ncompras',
      //                         style: TextStyle(fontSize: 18),
      //                       ),
      //                     ), // Texto en la parte inferior
      //                   ],
      //                 ),
      //               ),
      //               /*BOTON CREAR GEMAS */
      //               ElevatedButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => GemCreateScreen(
      //                         accessToken: accessToken,
      //                       ),
      //                     ),
      //                   );
      //                 },
      //                 style: ButtonStyle(
      //                     backgroundColor: const MaterialStatePropertyAll(
      //                         Color.fromARGB(255, 82, 113, 255)),
      //                     shape:
      //                         MaterialStateProperty.all<RoundedRectangleBorder>(
      //                             RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.circular(30.0),
      //                     )),
      //                     minimumSize: MaterialStateProperty.all<Size>(
      //                       const Size(100, 150),
      //                     ), // Establece el tamaño mínimo del botón
      //                     padding: MaterialStateProperty.all<EdgeInsets>(
      //                       const EdgeInsets.all(10),
      //                     ) // Establece el padding interno del botón
      //                     ),
      //                 child: const Column(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   children: [
      //                     Icon(
      //                       Icons.diamond,
      //                       size: 70,
      //                     ), // Icono en la parte superior
      //                     Padding(
      //                       padding: EdgeInsets.all(8.0),
      //                       child: Text(
      //                         'Crear \ngemas',
      //                         style: TextStyle(fontSize: 18),
      //                       ),
      //                     ), // Texto en la parte inferior
      //                   ],
      //                 ),
      //               ),
      //               // ElevatedButton(
      //               //   onPressed: () {
      //               //     // Acción cuando se presiona el botón
      //               //   },
      //               //   style: ButtonStyle(
      //               //       backgroundColor: const MaterialStatePropertyAll(
      //               //           Color.fromARGB(255, 82, 113, 255)),
      //               //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //               //           RoundedRectangleBorder(
      //               //         borderRadius: BorderRadius.circular(30.0),
      //               //       )),
      //               //       minimumSize: MaterialStateProperty.all<Size>(
      //               //         const Size(130, 150),
      //               //       ), // Establece el tamaño mínimo del botón
      //               //       padding: MaterialStateProperty.all<EdgeInsets>(
      //               //         const EdgeInsets.all(10),
      //               //       ) // Establece el padding interno del botón
      //               //       ),
      //               //   child: const Column(
      //               //     mainAxisAlignment: MainAxisAlignment.start,
      //               //     children: [
      //               //       Icon(
      //               //         Icons.outbond,
      //               //         size: 70,
      //               //       ), // Icono en la parte superior
      //               //       Padding(
      //               //         padding: EdgeInsets.all(8.0),
      //               //         child: Text(
      //               //           'Cerrar \nsesión',
      //               //           style: TextStyle(fontSize: 18),
      //               //         ),
      //               //       ), // Texto en la parte inferior
      //               //     ],
      //               //   ),
      //               // )
      //             ],
      //           ),
      //           const SizedBox(height: 50),
      //           Container(
      //             width: MediaQuery.of(context).size.width,
      //             height: 375,
      //             decoration: const BoxDecoration(
      //               color: Colors.white,
      //               borderRadius: BorderRadius.only(
      //                 topLeft: Radius.circular(50),
      //                 topRight: Radius.circular(50),
      //               ),
      //             ),
      //             child: Column(
      //               children: [
      //                 const Align(
      //                   alignment: Alignment.topLeft,
      //                   child: Padding(
      //                     padding: EdgeInsets.only(
      //                       left: 34.0,
      //                       top: 34.0,
      //                       bottom: 34.0,
      //                     ),
      //                     child: Text(
      //                       "Carrito de Compras",
      //                       style: TextStyle(
      //                         fontSize: 22,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 32,
      //                 ),
      //                 const Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     Icon(
      //                       Icons.add_shopping_cart,
      //                       size: 80,
      //                     ),
      //                     Column(
      //                       children: [
      //                         Text(
      //                           "Your shopping cart is empty.",
      //                           style: TextStyle(
      //                             fontSize: 20,
      //                             fontWeight: FontWeight.bold,
      //                           ),
      //                         ),
      //                         Text(
      //                           "Check the gem catalog to view \nthem here...",
      //                           style: TextStyle(fontSize: 18),
      //                         ),
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 const SizedBox(height: 60),
      //                 ElevatedButton(
      //                   style: ButtonStyle(
      //                     backgroundColor: const MaterialStatePropertyAll(
      //                         Color.fromARGB(255, 0, 0, 0)),
      //                     shape:
      //                         MaterialStateProperty.all<RoundedRectangleBorder>(
      //                       RoundedRectangleBorder(
      //                         borderRadius: BorderRadius.circular(8.0),
      //                       ),
      //                     ),
      //                   ),
      //                   onPressed: () {},
      //                   child: const Padding(
      //                     padding: EdgeInsets.only(
      //                         left: 0, right: 0, bottom: 15, top: 15),
      //                     child: Text(
      //                       'Go to Checkout',
      //                       style: TextStyle(
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           )
      //         ],
      //       );
      //     }
      //   },
      // ),
    );
  }
}
