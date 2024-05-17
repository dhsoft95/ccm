import 'package:ccm/Models/supporter.dart';
import 'package:ccm/Providers/supporterProvider.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:iconly/iconly.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../../Models/locations.dart';
import '../../Providers/dataProvider.dart';
import 'contacts.dart';

class AddSupporter extends StatefulWidget {
  const AddSupporter({super.key});

  @override
  State<AddSupporter> createState() => _AddSupporterState();
}

class _AddSupporterState extends State<AddSupporter> {
  late SupporterProvider supporterProvider;
  late DataProvider dataProvider;
  List<Region> _regions = [];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  District? selectedDistrict;
  Village? selectedVillage;
  Region? selectedRegion;
  Ward? selectedWard;
  String _selectedGender = "";
  String promised = "";

  @override
  void didChangeDependencies() {
    supporterProvider = Provider.of<SupporterProvider>(context);
    dataProvider = Provider.of<DataProvider>(context);
    _regions = dataProvider.regions;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                      'Add Member',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: TextFormField(
                                  controller: firstNameController,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    labelText: 'First Name',
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: TextFormField(
                                  controller: lastNameController,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.white,
                                  decoration: InputDecoration(
                                    labelText: 'Last Name',
                                    labelStyle:
                                        const TextStyle(color: Colors.white),
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
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gender",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Male',
                                      groupValue: _selectedGender,
                                      onChanged: (value) => setState(
                                          () => _selectedGender = value!),
                                      activeColor: Colors.white,
                                    ),
                                    Text(
                                      'Male',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: 'Female',
                                      groupValue: _selectedGender,
                                      onChanged: (value) => setState(
                                          () => _selectedGender = value!),
                                      activeColor: Colors.white,
                                    ),
                                    Text(
                                      'Female',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Promised",
                              style: TextStyle(color: Colors.white),
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "Yes",
                                      groupValue: promised,
                                      onChanged: (value) =>
                                          setState(() => promised = value!),
                                      activeColor: Colors.white,
                                    ),
                                    Text(
                                      'Yes',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio<String>(
                                      value: "No",
                                      groupValue: promised,
                                      onChanged: (value) =>
                                          setState(() => promised = value!),
                                      activeColor: Colors.white,
                                    ),
                                    Text(
                                      'No',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: phoneNumberController,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                                onPressed: () async {
                                  final Contact contact = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => ContactPickerDemo()));
                                  Map number = await parse(
                                      contact.phones!.first.value.toString());
                                  setState(() {
                                    phoneNumberController.text = number['e164'];
                                  });
                                },
                                icon: Icon(
                                  Symbols.contacts,
                                  color: Colors.white,
                                )),
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            labelText: 'Region',
                            hintText: "Select Region",
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
                            decoration: InputDecoration(
                              labelText: 'State',
                              hintText: 'Select State',
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
                            decoration: InputDecoration(
                              labelText: 'Village',
                              hintText: 'Select Village',
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
                            value: selectedVillage,
                            onChanged: (newValue) {
                              setState(() {
                                selectedVillage = newValue!;
                              });
                            },
                            items: selectedDistrict?.villages!
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
                            selectedVillage != null) ...[
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Ward',
                              hintText: 'Select Ward',
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
                        TextFormField(
                          controller: detailsController,
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText:
                                "Enter interesting details about the supporter (optional)",
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle:
                                TextStyle(color: Colors.white.withOpacity(0.8)),
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: addMember,
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
                                  'Add',
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

  addMember() async {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        _selectedGender.isNotEmpty &&
        phoneNumberController.text.isNotEmpty &&
        promised.isNotEmpty &&
        selectedDistrict != null &&
        selectedVillage != null &&
        selectedWard != null &&
        selectedRegion != null) {
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
      await supporterProvider.addSupporter(
          supporter: Supporter(
              first_name: firstNameController.text,
              last_name: lastNameController.text,
              phone_number: number['e164'],
              region_id: selectedRegion?.id,
              ward_id: selectedWard?.id,
              village_id: selectedVillage?.id,
              district_id: selectedDistrict?.id,
              other_supporter_details: detailsController.text.toString(),
              promised: promised == 'Yes' ? 1 : 0,
              gender: _selectedGender));
      Navigator.pop(context);
      if (supporterProvider.supporterAdded) {
        Navigator.pop(context);
      }
    }
  }
}
