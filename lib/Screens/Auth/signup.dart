import 'package:ccm/Models/positions.dart';
import 'package:ccm/Providers/authProvider.dart';
import 'package:ccm/Providers/dataProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:iconly/iconly.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import '../../Models/User.dart';
import '../../Models/locations.dart';
import '../Tabs/home.dart';
import 'login.dart';
import 'otp.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late AuthProvider authProvider;
  late DataProvider dataProvider;
  List<Region> _regions = [];
  List<Positions> _positions = [];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController _mtaa = TextEditingController();
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
  List<String> dropdownItemsDis = [];
  List<String> dropdownItemskata = [
    'Magomen',
    'Buza',
    'Mtambani',
    'Kimara',
  ];
  List<String> dropdownItemPosition = [
    'M/Kiti wa Mtaa/Kijiji ',
    'Diwani',
    'Mbunge',
  ];
  District? selectedDistrict;
  Village? selectedVillage;
  Region? selectedRegion;
  Ward? selectedWard;
  Positions? selectedPosition;

  @override
  void didChangeDependencies() {
    authProvider = Provider.of<AuthProvider>(context);
    dataProvider = Provider.of<DataProvider>(context);
    _regions = dataProvider.regions;
    _positions = dataProvider.positions;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedRegion.toString() == 'Dar es Salaam') {
      dropdownItemsDis = [
        'Ilala Municipal Council',
        'Kinondoni Municipal Council',
        'Temeke Municipal Council',
        'Kigamboni Municipal Council ',
        'Ubungo Municipal Council',
      ];
      setState(() {});
    } else if (selectedRegion.toString() == 'Arusha') {
      dropdownItemsDis = ['Monduli', 'Arumeru', 'Usa river'];
      setState(() {});
    } else {
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
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      CupertinoIcons.chevron_back,
                      size: 32,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip:
                        MaterialLocalizations.of(context).backButtonTooltip,
                  );
                },
              ),
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
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Nafasi',
                            hintText: 'Chagua Nafasi Unayogombea',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
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
                          value: selectedPosition,
                          onChanged: (newValue) {
                            setState(() {
                              selectedPosition = newValue!;
                            });
                          },
                          items: _positions
                              .map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name.toString(),
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: fullNameController,
                          style:  const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Majina yako mawili',
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
                          controller: emailController,
                          style:  const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: "Weka barua pepe yako",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle:  TextStyle(color: Colors.white.withOpacity(0.7)),
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
                          style:  const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Namba ya simu ',
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
                          style:  const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
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
                        DropdownButtonFormField(iconEnabledColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Mkoa',
                            hintText: "changua Mkoa",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white),
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
                          value: selectedRegion,
                          onChanged: (newValue) {
                            setState(() {
                              selectedRegion = newValue!;
                              selectedDistrict = null;
                            });
                          },
                          items: _regions.map<DropdownMenuItem>((Region value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                value.name.toString(),
                                style: const TextStyle(color: Colors.green),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        if (selectedRegion != null) ...[
                          DropdownButtonFormField(
                            iconEnabledColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: 'Jimbo',
                              hintText: 'Changua Jimbo',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
                              prefixIcon: const Icon(
                                IconlyLight.location,
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
                            value: selectedDistrict,
                            onChanged: (newValue) {
                              setState(() {
                                selectedDistrict = newValue!;
                              });
                            },
                            items: selectedRegion?.districts!
                                .map<DropdownMenuItem>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.name.toString(),
                                  style: const TextStyle(color: Colors.green),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                        ],
                        if (selectedDistrict != null) ...[
                          DropdownButtonFormField(
                            iconEnabledColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: 'Kata',
                              hintText: 'Chagua Kata ',
                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),
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
                            value: selectedWard,
                            onChanged: (newValue) {
                              setState(() {
                                selectedWard = newValue!;
                              });
                            },
                            items: selectedDistrict?.wards!
                                .map<DropdownMenuItem>((value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value.name.toString(),
                                  style: const TextStyle(color: Colors.green),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                        ],

                        if (selectedDistrict != null &&
                            selectedWard != null) ...[
                          TextFormField(
                            controller: _mtaa,
                            style:  const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              labelText: 'Mtaa/Kijiji',
                              labelStyle: const TextStyle(color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                              prefixIcon: Icon(IconlyLight.home, color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        TextFormField(
                          controller: detailsController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                "Enter interesting details about yourself (optional)",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle:  TextStyle(color: Colors.white.withOpacity(0.8)),
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
                          onPressed: register,
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

  register() async {
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        fullNameController.text.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        _mtaa.text.isNotEmpty &&
        selectedDistrict != null &&
        selectedWard != null &&
        selectedRegion != null &&
        selectedPosition != null) {
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

      Map number = await parse(phoneNumberController.text, region: "TZ");
      authProvider.registerUser = User(
          full_name: fullNameController.text,
          phone: number['e164'],
          email: emailController.text,
          password: passwordController.text,
          region_id: selectedRegion?.id,
          ward_id: selectedWard?.id,
          village_id: _mtaa.text.toString(),
          district_id: selectedDistrict?.id,
          position_id: selectedPosition?.id.toString(),
          party_affiliation: "CCM",
          other_candidate_details: detailsController.text.toString());

      await authProvider.sendOtp(phone: number['e164'].toString());

      Navigator.pop(context);
      if (authProvider.otpSent) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => OTPConfirmationScreen()));
      }
    }
  }
}
