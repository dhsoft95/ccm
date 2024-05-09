import 'package:ccm/Providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'Screens/Auth/login.dart'; // Import your login screen

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>AuthProvider())
    ],
      child: const MyApp()));
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
