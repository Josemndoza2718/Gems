import 'package:appapijtest/presentation/7/gemcreate/gemcreatescreen.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget {
  final String accessToken;

  UserScreen({required this.accessToken});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  String accessToken = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String accessToken = '';
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/331/331988.png")),
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Inicio",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.diamond_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Crear Gema",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GemCreateScreen(accessToken: accessToken),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.shop_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Mis Compras",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
              title: const Text(
                "Notificaciones",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
              title: const Text(
                "Borra Gema",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.outbond_outlined,
                color: Colors.white,
              ),
              title: const Text(
                "Cerrar Sensión",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
