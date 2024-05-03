import 'package:flutter/material.dart';
import 'login.dart'; // Import your login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bunge App',
      theme: ThemeData.light(),

      debugShowCheckedModeBanner: false,// Set the dark theme
      // Use themeMode to adopt from the system's theme
      themeMode: ThemeMode.system,

      home: const LoginScreen(), // Removed the extra "home:" and the extra ","
    );
  }
}
