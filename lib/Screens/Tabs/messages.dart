import 'package:ccm/Providers/supporterProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<Messages> {
  late SupporterProvider supporterProvider;
  final TextEditingController fromController = TextEditingController();
  final TextEditingController toController = TextEditingController();
  final TextEditingController textMessagesController = TextEditingController();
  List<String> sendTypeItems = ['Individual SMS', 'Group SMS'];

  String? sendType;

  @override
  void didChangeDependencies() {
    supporterProvider = Provider.of<SupporterProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        backgroundColor: const Color(0xff009b65),
        title: Text(
          'Bunge App',
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
                Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      'assets/message.png',
                      width: 200,
                      height: 220,
                    ),
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
                      // New form inputs for From, To, and Text Messages
                      // TextField(
                      //   controller: fromController,
                      //   style: const TextStyle(color: Colors.white),
                      //   decoration: InputDecoration(
                      //     labelText: 'From',
                      //     labelStyle: const TextStyle(color: Colors.white),
                      //     prefixIcon: const Icon(
                      //       Icons.person,
                      //       color: Colors.white,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      // DropdownButtonFormField(
                      //   decoration: InputDecoration(
                      //     labelText: 'Send To',
                      //     labelStyle: const TextStyle(color: Colors.white),
                      //     prefixIcon: const Icon(
                      //       Icons.add_chart_sharp,
                      //       color: Colors.white,
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      //   style: const TextStyle(color: Colors.white),
                      //   value: sendType,
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       sendType = newValue!;
                      //     });
                      //   },
                      //   items: sendTypeItems
                      //       .map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(
                      //         value,
                      //         style: const TextStyle(color: Colors.green),
                      //       ),
                      //     );
                      //   }).toList(),
                      // ),
                      // const SizedBox(height: 20),
                      // TextField(
                      //   controller: toController,
                      //   style: const TextStyle(color: Colors.white),
                      //   decoration: InputDecoration(
                      //     labelText: 'To',
                      //     labelStyle: const TextStyle(color: Colors.white),
                      //     prefixIcon: const Icon(
                      //       Icons.email,
                      //       color: Colors.white,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: const BorderSide(
                      //         color: Colors.white,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 20),
                      TextFormField(
                        controller: textMessagesController,
                        maxLines: 5, // Set to null to allow multiple lines
                        style: const TextStyle(
                            color: Colors.white), // Set text color to white
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
                          backgroundColor:
                              const Color(0xff009b65), // Background color
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

  sendMessage() async {
    if (textMessagesController.text.isNotEmpty) {
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
      await supporterProvider.sendMessage(message: textMessagesController.text);
      Navigator.pop(context);
      if (supporterProvider.messageSent) {
        Navigator.pop(context);
      }
    }
  }
}
