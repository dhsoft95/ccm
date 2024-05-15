import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class ContactPickerDemo extends StatefulWidget {
  @override
  _ContactPickerDemoState createState() => _ContactPickerDemoState();
}

class _ContactPickerDemoState extends State<ContactPickerDemo> {
  List<Contact> _contacts = [];
  bool _isLoading = false;
  PermissionStatus status = PermissionStatus.denied; // Add default value

  @override
  void initState() {
    _pickContacts();
    super.initState();
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
                size: 32,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: Text('Contact Picker'),
        centerTitle: true, // Center the title
        backgroundColor: Colors.teal, // Match app bar color
        actions: [
          IconButton(
            icon: Icon(Icons.search), // Add search icon
            onPressed: () => {}, // Implement search functionality later
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (BuildContext context, int index) {
                final phone = _contacts[index].phones?.isNotEmpty ?? false
                    ? _contacts[index].phones!.first.value
                    : 'No phone number';
                return ContactListTile(
                  contact: _contacts[index],
                  onClick: () {
                  Navigator.pop(context,_contacts[index]);
                  },
                );
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('No contacts found!')));
        }
      } catch (e) {
        // Handle errors during contact fetching
        print(e.toString());
      }
    } else {
      // Handle permission denial
      await Permission.contacts.request();
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
  final Function() onClick;

  const ContactListTile({required this.contact, required this.onClick});

  @override
  Widget build(BuildContext context) {
    final phoneNumber = contact.phones?.isNotEmpty ?? false
        ? contact.phones!.first.value
        : 'No phone number'; // Use final variable for clarity
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: contact.avatar != null && contact.avatar!.isNotEmpty
          ? CircleAvatar(backgroundImage: MemoryImage(contact.avatar!))
          : CircleAvatar(child: Text(contact.initials())),
      title: Text(contact.displayName ?? ''),
      subtitle: Text(phoneNumber ?? ''), // Use the final variable
      onTap: onClick,
    );
  }
}
