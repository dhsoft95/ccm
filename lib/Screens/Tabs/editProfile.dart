import 'package:ccm/Models/User.dart';
import 'package:ccm/Services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/positions.dart';
import '../../Providers/authProvider.dart';
import '../../Providers/dataProvider.dart';

class EditProfileData extends StatefulWidget {
  const EditProfileData({super.key});

  @override
  State<EditProfileData> createState() => _EditProfileDataState();
}

class _EditProfileDataState extends State<EditProfileData> {
  late DataProvider dataProvider;
  late AuthProvider authProvider;
  late LocalStorageProvider storageProvider;
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _name = TextEditingController();
  List<Positions> _positions = [];
  Positions? selectedPosition;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    storageProvider = Provider.of<LocalStorageProvider>(context, listen: false);

    try {
      if (storageProvider.user!.email != null) {
        _email = TextEditingController(text: storageProvider.user!.email);
      }
      if (storageProvider.user!.phone != null) {
        _phone = TextEditingController(text: storageProvider.user!.phone);
      }
      if (storageProvider.user!.full_name != null) {
        _name = TextEditingController(text: storageProvider.user!.full_name);
      }
      if(storageProvider.user!.position_name != null){
        selectedPosition =Provider.of<DataProvider>(context,listen: false).positions.firstWhere((element) => element.name.toString().toLowerCase()==storageProvider.user!.position_name.toString().toLowerCase());
      }
    } catch (e) {
      print(e.toString());
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    storageProvider = Provider.of<LocalStorageProvider>(context);
    dataProvider = Provider.of<DataProvider>(context);
    authProvider = Provider.of<AuthProvider>(context);
    _positions = dataProvider.positions;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff009b65),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                CupertinoIcons.chevron_back,
                color: Colors.white,
                size: 28,
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
          "Edit Profile",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    iconColor: Colors.white,
                    suffixIconColor: Colors.white,
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
                  items: _positions.map<DropdownMenuItem>((value) {
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
                  controller: _name,
                  style: const TextStyle(color: Colors.white),
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
                  controller: _email,
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: "Weka barua pepe yako",
                    labelStyle: const TextStyle(color: Colors.white),
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
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
                  controller: _phone,
                  style: const TextStyle(color: Colors.white),
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
                ElevatedButton(
                  onPressed: _update,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.person_add,
                          color: Colors.green,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Update',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _update() async {
    if (_formKey.currentState!.validate()) {
      if (_name.text.isNotEmpty &&
          _email.text.isNotEmpty &&
          _phone.text.isNotEmpty &&
          selectedPosition != null) {
        showDialog(
            context: context,
            // barrierDismissible: false,
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
        await authProvider.updateProfile(
            userData: User(
          full_name: _name.text,
          email: _email.text,
          phone: _phone.text,
          position_id: selectedPosition!.id,
        ));
        if(authProvider.profileUpdated){
          await storageProvider.initialize();
          Navigator.pop(context);
          Navigator.pop(context);
        }else{
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to update profile",style: TextStyle(fontSize: 16),),
            backgroundColor: Colors.red,
          ));
        }
      }
    }
  }
}
