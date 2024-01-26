import 'package:appapijtest/presentation/5/getallgems/getallgemscreen.dart';
import 'package:flutter/material.dart';

class BuyGems extends StatefulWidget {
  const BuyGems({super.key});

  @override
  State<BuyGems> createState() => _BuyGemsState();
}

class _BuyGemsState extends State<BuyGems> {
  GemstoneSort gemstoneSort = GemstoneSort.HighestPrice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                ),
                const SizedBox(height: 30),
                Column(
                  //maiAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.only(
                        left: 30.0,
                      ),
                      child: Text(
                        "Hola Bienvenido de vuelta",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    //const SizedBox(height: 0),
                    Center(
                      child: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/147/147258.png",
                        width: 250,
                        height: 250,
                        alignment: Alignment.center,
                      ),
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
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
                        height: 100, // Altura deseada de la tarjeta
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.add_card,
                              size: 55,
                              color: Color(0xff5271FF),
                            ),
                            Icon(
                              Icons.monetization_on_rounded,
                              size: 55,
                              color: Color(0xffFF5757),
                            ),
                            Icon(
                              Icons.money,
                              size: 55,
                              color: Colors.green,
                            ),
                            Icon(
                              Icons.add_shopping_cart_outlined,
                              size: 55,
                              color: Color(0xff5E17EB),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 50),
            Wrap(
              spacing: 8.0,
              children: [
                FilterChip(
                  label: const Text(
                    'Compras reciente',
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
                    'Compras antiguas',
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
            Compras()
          ],
        ),
      ),
    );
  }

  Compras() {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Radio de los bordes deseados
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart_checkout,
                          size: 50,
                          color: Color(0xff5E17EB),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Emerald",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "4:50PM",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$140.00",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Radio de los bordes deseados
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart_checkout,
                          size: 50,
                          color: Color(0xff5E17EB),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ruby",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "4:50PM",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$950.00",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            color: const Color.fromARGB(255, 255, 255, 255),
            margin: const EdgeInsets.only(right: 20, left: 20, top: 10),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(10), // Radio de los bordes deseados
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.shopping_cart_checkout,
                          size: 50,
                          color: Color(0xff5E17EB),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Diamond",
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                "4:50PM",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        /*#################
                                      # Datos de Compra #
                                      ###################*/
                        Container(
                          color: Colors.transparent,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "\$60.00",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        /*#################
                          # Datos de Compra #
                          ###################*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
