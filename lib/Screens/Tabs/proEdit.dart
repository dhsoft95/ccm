import 'package:ccm/Providers/authProvider.dart';
import 'package:ccm/Providers/supporterProvider.dart';
import 'package:ccm/Resources/formats.dart';
import 'package:ccm/Screens/Auth/login.dart';
import 'package:ccm/Screens/Tabs/editProfile.dart';
import 'package:ccm/Services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final storageProvider = Provider.of<LocalStorageProvider>(context);

    String initials =
        storageProvider.user!.full_name.toString().extractInitials();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text(
          'User Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff009b65),
        elevation: 0,
        actions: [
          const SizedBox(width: 48), // Placeholder to balance the leading icon
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff009b65), Color(0xff0d1018)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                height: 110,
                child: Material(
                  elevation: 5,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                    side: BorderSide.none,
                  ),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      radius: 55,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                storageProvider.user!.full_name.toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                storageProvider.user!.position_name.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[300],
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: Colors.white),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 24,
                ),
                title: Text(
                  storageProvider.user!.email.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 24,
                ),
                title: Text(
                  storageProvider.user!.phone.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => EditProfileData()));
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.85, 55),
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
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  await LocalStorage.logout();
                  Provider.of<SupporterProvider>(context, listen: false)
                      .supporters = [];
                  Provider.of<SupporterProvider>(context, listen: false)
                      .supporterAdded = false;
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0xff009b65),
                  backgroundColor: Colors.white,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.85, 55),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Logout',
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
