import 'dart:convert';
import 'package:ccm/Providers/supporterProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'home.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late SupporterProvider supporterProvider;
  final TextEditingController textMessagesController = TextEditingController();

  @override
  void didChangeDependencies() {
    supporterProvider = Provider.of<SupporterProvider>(context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () => Navigator.pop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        backgroundColor: const Color(0xff009b65),
        title: Text(
          'Ccm Yetu',
          style: GoogleFonts.roboto(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'assets/message.png',
                    width: 200,
                    height: 220,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Send your Messages',
                  style: GoogleFonts.roboto(
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
                        controller: textMessagesController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Message to send',
                          hintStyle: const TextStyle(color: Colors.grey),
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
                        onPressed: sendMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff009b65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.send, color: Color(0xfffcea97)),
                              SizedBox(width: 8),
                              Text(
                                'Send',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfffcea97),
                                ),
                              ),
                            ],
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

  void sendMessage() async {
    if (textMessagesController.text.isEmpty) {
      _showErrorDialog('Please enter a message before sending.');
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      Map<String, dynamic> response = await supporterProvider.sendMessage(
        message: textMessagesController.text,
      );
      Navigator.pop(context); // Close the loading dialog

      if (response['error'] == true) {
        _showErrorDialog(response['message']);
      } else {
        _showSuccessDialog(response);
      }
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      print('Error sending message: $e');
      _showErrorDialog('An unexpected error occurred: ${e.toString()}');
    }
  }

  void _showSuccessDialog(Map<String, dynamic> messageData) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.SUCCESS,
      title: const Text('Message Sent Successfully'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Text('Recipient: ${messageData['recipient']}'),
          const SizedBox(height: 8),
          Text('Message: ${messageData['message']}'),
        ],
      ),
      confirmButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
          textMessagesController.clear();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text('OK', style: TextStyle(color: Colors.white)),
      ),
    ).show();
  }

  void _showErrorDialog(String message) {
    StylishDialog(
      context: context,
      alertType: StylishDialogType.ERROR,
      title: const Text('Error'),
      content: Text(message),
      confirmButton: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text('OK', style: TextStyle(color: Colors.white)),
      ),
    ).show();
  }
}
