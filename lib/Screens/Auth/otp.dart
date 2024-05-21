import 'package:ccm/Providers/authProvider.dart';
import 'package:ccm/Screens/Tabs/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/supporterProvider.dart';
import '../../Services/storage.dart';

class OTPConfirmationScreen extends StatefulWidget {
  const OTPConfirmationScreen({super.key});

  @override
  _OTPConfirmationScreenState createState() => _OTPConfirmationScreenState();
}

class _OTPConfirmationScreenState extends State<OTPConfirmationScreen> {
  final TextEditingController otpController = TextEditingController();
  late AuthProvider authProvider;

  @override
  void didChangeDependencies() {
    authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/ccm_logo.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'OTP Confirmation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Enter OTP',
                          labelStyle: const TextStyle(color: Colors.white),
                          prefixIcon: const Icon(
                            Icons.confirmation_number,
                            color: Colors.white,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: otpVerification,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff009b65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: const Text(
                            'Confirm OTP',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {
                          // Handle navigation back to the login screen
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Back to Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  otpVerification() async {
    if (otpController.text.isNotEmpty) {
      if (otpController.text.toString() ==
          authProvider.otpVerifier.toString()) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Container(
                  height: 100,
                  width: 100,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ),
                ),
              );
            });
        await authProvider.register();
        await Future.wait([
          Provider.of<LocalStorageProvider>(context, listen: false)
              .initialize(),
          Provider.of<SupporterProvider>(context, listen: false).getMessages(),
          Provider.of<SupporterProvider>(context, listen: false)
              .getMessagesCount(),
        ]);
        Navigator.pop(context);
        if (authProvider.currentUser != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
              (route) => false);
        }
      }
    }
  }
}
