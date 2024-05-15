import 'package:ccm/Providers/authProvider.dart';
import 'package:ccm/Providers/dataProvider.dart';
import 'package:ccm/Screens/Tabs/home.dart';
import 'package:ccm/Services/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'Providers/supporterProvider.dart';
import 'Screens/Auth/login.dart'; // Import your login screen

final dataProvider = DataProvider();
final localProvider = LocalStorageProvider();

Widget? _landingPage;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Future.wait([
    dataProvider.getRegionData(),
    dataProvider.getPositionsData(),
    localProvider.initialize(),
  ]);
  if(await LocalStorage.checkSession()){
    _landingPage = DashboardScreen();
  }else{
    _landingPage = LoginScreen();
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=>AuthProvider()),
      ChangeNotifierProvider(create: (_)=>SupporterProvider()),
      ChangeNotifierProvider.value(value: dataProvider),
      ChangeNotifierProvider.value(value: localProvider)
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

      home: _landingPage, // Removed the extra "home:" and the extra ","
    );
  }
}
