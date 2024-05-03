import 'package:flutter/material.dart';
import 'login.dart';
import 'otp.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  List<String> dropdownItems = [
    'Arusha',
    'Dar es Salaam',
    'Dodoma',
    'Geita',
    'Iringa',
    'Kagera',
    'Katavi',
    'Kigoma',
    'Kilimanjaro',
  ];
  List<String> dropdownItemsDis = [
  ];
  List<String> dropdownItemskata = [
    'Magomen',
    'Buza',
    'Mtambani',
    'Kimara',
  ];
  List<String> dropdownItemPosition = [
    'Mbunge',
    'Mtendaji kata',
    'Mwenyekiti',
  ];
  String? selectedDist;
  String? selectedKata;
  String? selectedCountry;
  String? selectedPosition;
  @override
  Widget build(BuildContext context) {
    if (selectedCountry.toString() == 'Dar es Salaam') {
      dropdownItemsDis = [
        'Ilala Municipal Council',
        'Kinondoni Municipal Council',
        'Temeke Municipal Council',
        'Kigamboni Municipal Council ',
        'Ubungo Municipal Council',
      ];
      setState(() {

      });
    } else if (selectedCountry.toString() == 'Arusha') {
      dropdownItemsDis = ['Monduli', 'Arumeru', 'Usa river'];
      setState(() {

      });
    }else{
      dropdownItemsDis = [
        'District 1',
        'District 2',
        'District 3',
        'District 4',
      ];
    }

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              expandedHeight: screenHeight * 0.1,
              flexibleSpace: FlexibleSpaceBar(
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: Colors.white,
                    //   ),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(10.0),
                    //     child: Image.asset(
                    //       'assets/ccm_logo.png',
                    //       width: 50,
                    //       height: 50,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    const Text(
                      'Registration',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color(0xff009b65),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Position',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.account_box_rounded,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
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
                          style: const TextStyle(color: Colors.white),
                          value: selectedPosition,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPosition = newValue!;
                            });
                          },
                          items: dropdownItemPosition
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: fullNameController,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.person,
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
                        TextFormField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.phone,
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
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.lock,
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
                          obscureText: true,
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Region',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
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
                          style: const TextStyle(color: Colors.white),
                          value: selectedCountry,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountry = newValue!;
                              selectedDist=null;
                            });
                          },
                          items: dropdownItems
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                       if(selectedCountry!=null && selectedCountry!.isNotEmpty)...[DropdownButtonFormField(
                         decoration: InputDecoration(
                           labelText: 'District',
                           labelStyle: const TextStyle(color: Colors.white),
                           prefixIcon: const Icon(
                             Icons.account_box_rounded,
                             color: Colors.white,
                           ),
                           enabledBorder: OutlineInputBorder(
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
                         style: const TextStyle(color: Colors.white),
                         value: selectedDist,
                         onChanged: (String? newValue) {
                           setState(() {
                             selectedDist = newValue!;
                           });
                         },
                         items: dropdownItemsDis
                             .map<DropdownMenuItem<String>>((String value) {
                           return DropdownMenuItem<String>(
                             value: value,
                             child: Text(
                               value,
                               style: const TextStyle(color: Colors.green),
                             ),
                           );
                         }).toList(),
                       ),
                         const SizedBox(height: 20),] ,
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'State',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.add_chart_sharp,
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
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
                          style: const TextStyle(color: Colors.white),
                          value: selectedKata,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedKata = newValue!;
                            });
                          },
                          items: dropdownItemskata
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const OTPConfirmationScreen()));
                          },
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
                                Icon(
                                  Icons.person_add,
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Register',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow,
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
          ],
        ),
      ),
    );
  }
}
