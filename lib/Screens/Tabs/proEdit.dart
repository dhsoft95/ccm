import 'package:ccm/Providers/authProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(CupertinoIcons.chevron_back,color: Colors.white,),
              onPressed: () { Navigator.pop(context); },
              tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            );
          },
        ),
        title: const Text('User Profile',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 24),),
        centerTitle: true,
        backgroundColor: const Color(0xff009b65),
        elevation: 0, // Remove app bar shadow
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/dhsoft.jpg'),
              ),
              const SizedBox(height: 16),
               Text(
                authProvider.currentUser!.full_name.toString(),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontFamily: 'Roboto', // Use your custom font
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Software Developer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[300],
                  fontFamily: 'Roboto', // Use your custom font
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white),
              const SizedBox(height: 16),
               ListTile(
                leading: Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 24,
                ),
                title: Text(
                  authProvider.currentUser!.email.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 24,
                ),
                title: Text(
                  '+1 (555) 123-4567',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.white,
                  size: 24,
                ),
                title: Text(
                  '123 Main Street, Cityville',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add your edit button functionality here
                  print('Edit button pressed');
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff009b65), backgroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff009b65),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
