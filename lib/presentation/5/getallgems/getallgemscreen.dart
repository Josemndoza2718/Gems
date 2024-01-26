import 'package:appapijtest/infrastructure/models/gemas_all.dart';
import 'package:appapijtest/main.dart';
import 'package:appapijtest/presentation/4/home/homescreen.dart';
import 'package:appapijtest/presentation/6/props/propspage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class GetAllGemsScreen extends StatefulWidget {
  final String accessToken;

  GetAllGemsScreen({required this.accessToken});

  @override
  _GetAllGemsScreenState createState() => _GetAllGemsScreenState();
}

enum GemstoneSort { HighestPrice, LowestPrice }

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

class SharedPreferencesUtils {
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString("token"));
    return prefs.getString('token');
  }
}

class _GetAllGemsScreenState extends State<GetAllGemsScreen> {
  late Future<List<GemAll>> gemstonesFuture;
  List<String> selectedTypes = [];
  GemstoneSort gemstoneSort = GemstoneSort.HighestPrice;

  //String accessToken = '';

  @override
  void initState() {
    super.initState();
    gemstonesFuture = fetchGemstones();
    loadFullName();
    loadUserImage();
  }

  Future<List<GemAll>> fetchGemstones() async {
    String? token = await SharedPreferencesUtils.getToken();
    final url = Uri.parse('${globalVariable}/gems/all');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    print("Respuesta de código: ${response.statusCode}");
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> gemstonesData = json.decode(response.body);

      return gemstonesData.map((data) => GemAll.fromJson(data)).toList();
    } else if (response.statusCode == 403) {
      throw Exception("No autenticado");
    } else {
      throw Exception(
          'Failed to fetch gemstones. Status code: ${response.statusCode}');
    }
  }

  //Boton que lleva a la ventana de propiedades de las gemas
  void showGemstoneDetails(GemAll gemstone) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            GemstoneDetailsScreen.PropGemsPage(gemstone: gemstone),
      ),
    );
  }

  //Muestra las gemas en una Lista
  List<GemAll> getFilteredGemstones(List<GemAll> gemstonesData) {
    if (selectedTypes.isNotEmpty) {
      gemstonesData = gemstonesData
          .where((gemstone) => selectedTypes.contains(gemstone.gemType))
          .toList();
    }

    //Ordena las gemas de mayor a menor.
    if (gemstoneSort == GemstoneSort.HighestPrice) {
      gemstonesData.sort((a, b) => b.price.compareTo(a.id));
    } else if (gemstoneSort == GemstoneSort.LowestPrice) {
      gemstonesData.sort((a, b) => a.price.compareTo(b.id));
    }

    return gemstonesData;
  }

  String? profileImage;
  String? fullname;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GemAll>>(
        future: gemstonesFuture,
        builder: (BuildContext context, AsyncSnapshot<List<GemAll>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<GemAll>? gemstonesData = snapshot.data;
            List<GemAll>? filteredGemstonesData =
                getFilteredGemstones(gemstonesData!);

            return Column(
              children: [
                Stack(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            50), // Radio de los bordes deseados
                      ),
                      elevation: 20.0,
                      //margin: const EdgeInsets.all(20),
                      child: Container(
                        alignment: Alignment.center,
                        //padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
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
                            const Divider(
                                height: 40, color: Colors.transparent),
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
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => HomeScreen(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.keyboard_return_rounded))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        50), // Radio de los bordes deseados
                  ),
                  elevation: 20.0,
                  //margin: const EdgeInsets.all(20),
                  child: Container(
                    alignment: Alignment.center,
                    //padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    width: double.infinity, // Ancho máximo disponible
                    height: 180, // Altura deseada de la tarjeta
                    child: const Align(
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0, top: 8.0),
                            child: Text(
                              'Total Balance',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 8.0),
                            child: Text(
                              '149.868',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1.0),
                            child: ElevatedButton(
                              onPressed: null,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Color.fromARGB(255, 0, 191, 99))),
                              child: Text(
                                "+49.89%",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8.0,
                  children: [
                    // FilterChip(
                    //   label: const Text(
                    //     'DIAMOND',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   selected: selectedTypes.contains('DIAMOND'),
                    //   selectedColor: Colors.blue,
                    //   onSelected: (bool selected) {
                    //     setState(() {
                    //       if (selected) {
                    //         selectedTypes.add('DIAMOND');
                    //       } else {
                    //         selectedTypes.remove('DIAMOND');
                    //       }
                    //     });
                    //   },
                    // ),
                    // FilterChip(
                    //   label: const Text(
                    //     'EMERALD',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   selected: selectedTypes.contains('EMERALD'),
                    //   selectedColor: Colors.blue,
                    //   onSelected: (bool selected) {
                    //     setState(() {
                    //       if (selected) {
                    //         selectedTypes.add('EMERALD');
                    //       } else {
                    //         selectedTypes.remove('EMERALD');
                    //       }
                    //     });
                    //   },
                    // ),
                    // FilterChip(
                    //   label: const Text(
                    //     'RUBY',
                    //     style: TextStyle(color: Colors.white),
                    //   ),
                    //   selected: selectedTypes.contains('RUBY'),
                    //   selectedColor: Colors.blue,
                    //   onSelected: (bool selected) {
                    //     setState(() {
                    //       if (selected) {
                    //         selectedTypes.add('RUBY');
                    //       } else {
                    //         selectedTypes.remove('RUBY');
                    //       }
                    //     });
                    //   },
                    // ),
                    FilterChip(
                      label: const Text(
                        'Última creada',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: gemstoneSort == GemstoneSort.HighestPrice,
                      selectedColor: Colors.blue,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            gemstoneSort = GemstoneSort.HighestPrice;
                          } else {
                            gemstoneSort = GemstoneSort.LowestPrice;
                          }
                        });
                      },
                    ),
                    FilterChip(
                      label: const Text(
                        'Creada reciente',
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: gemstoneSort == GemstoneSort.LowestPrice,
                      selectedColor: Colors.blue,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            gemstoneSort = GemstoneSort.LowestPrice;
                          } else {
                            gemstoneSort = GemstoneSort.HighestPrice;
                          }
                        });
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 3,
                    ),
                    itemCount: filteredGemstonesData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => null,
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Radio de los bordes deseados
                            ),
                            elevation: 20.0,
                            // color: filteredGemstonesData[index]
                            //             .available
                            //             .toString() ==
                            //         "false"
                            //     ? Colors.red
                            //     : null,
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 0.0,
                                      ),
                                      child: Image.network(
                                        filteredGemstonesData[index].image,
                                        height: 55.0,
                                        width: 55.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          filteredGemstonesData[index].gemType,
                                          style: const TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(width: 4.0),
                                        Text(
                                          '\$${filteredGemstonesData[index].price.toString()}',
                                          style:
                                              const TextStyle(fontSize: 16.0),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          '${filteredGemstonesData[index].id}',
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 5.0),
                                    Column(
                                      children: [
                                        ElevatedButton(
                                            onPressed: () => showGemstoneDetails(
                                                filteredGemstonesData[index]),
                                            style: ButtonStyle(
                                                elevation:
                                                    const MaterialStatePropertyAll(
                                                        10.0),
                                                backgroundColor:
                                                    const MaterialStatePropertyAll(
                                                        Colors.white),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30.0)))),
                                            child: const Text(
                                              "View details",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            )),
                                        const SizedBox(height: 5),
                                        Text(
                                          filteredGemstonesData[index]
                                                      .available
                                                      .toString() ==
                                                  "false"
                                              ? "SOLD OUT"
                                              : "IN STOCK",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.w900,
                                            fontSize: 12.0,
                                            color: filteredGemstonesData[index]
                                                        .available
                                                        .toString() ==
                                                    "false"
                                                ? Colors.red
                                                : Colors.green,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 3)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
