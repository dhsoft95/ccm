import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Picker', // More concise title
      theme: ThemeData(
        primarySwatch: Colors.teal, // Example color scheme
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: 'Roboto'), // Set font family
        ),
      ),
      home: ContactPickerDemo(),
    );
  }
}

class ContactPickerDemo extends StatefulWidget {
  @override
  _ContactPickerDemoState createState() => _ContactPickerDemoState();
}

class _ContactPickerDemoState extends State<ContactPickerDemo> {
  List<Contact> _contacts = [];
  bool _isLoading = false;
  PermissionStatus status = PermissionStatus.denied; // Add default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Picker'),
        centerTitle: true, // Center the title
        backgroundColor: Colors.teal, // Match app bar color
        leading: IconButton(
          icon: Icon(Icons.search), // Add search icon
          onPressed: () => {}, // Implement search functionality later
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (BuildContext context, int index) {
          final phone = _contacts[index].phones?.isNotEmpty ?? false
              ? _contacts[index].phones!.first.value
              : 'No phone number';
          return ContactListTile(contact: _contacts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickContacts,
        tooltip: 'Pick Contacts',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _pickContacts() async {
    status = await Permission.contacts.request(); // Await for permission status
    // Permission handling
    if (status.isGranted) {
      if (mounted) {
        setState(() {
          _isLoading = true;
        });
      }
      try {
        Iterable<Contact>? contacts = await ContactsService.getContacts();
        if (contacts != null) {
          if (mounted) {
            setState(() {
              _contacts = contacts.toList();
              _isLoading = false;
            });
          }
          // Submit contacts to API (optional, uncomment if needed)
          // _submitContactsToApi(_contacts);
        } else {
          // Handle case where no contacts are found
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('No contacts found!')));
        }
      } catch (e) {
        // Handle errors during contact fetching
        print(e.toString());
      }
    } else {
      // Handle permission denial
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permission denied to access contacts!')));
    }
  }

  void _submitContactsToApi(List<Contact> contacts) async {
    // Implement your API call logic here
  }
}

class ContactListTile extends StatelessWidget {
  final Contact contact;

  const ContactListTile({required this.contact});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = contact.phones?.isNotEmpty ?? false
        ? contact.phones!.first.value
        : 'No phone number'; // Use final variable for clarity

    // Convert Uint8List to base64-encoded String
    String? imageUrl;
    if (contact.avatar != null && contact.avatar!.isNotEmpty) {
      final base64Image = base64Encode(contact.avatar!);
      imageUrl = 'data:image/jpeg;base64,$base64Image';
    }
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: imageUrl != null
          ? CircleAvatar(backgroundImage: NetworkImage(imageUrl))
          : CircleAvatar(child: Text(contact.initials())),
      title: Text(contact.displayName ?? ''),
      subtitle: Text(phoneNumber ?? ''), // Use the final variable
    );
  }
}
