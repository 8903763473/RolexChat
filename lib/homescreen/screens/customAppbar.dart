import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/login/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey.shade300,
      title: const Text('RolexChat'),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) => _handleMenuSelection(value, context),
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'profile',
              child: Text('Profile'),
            ),
            const PopupMenuItem<String>(
              value: 'notifications',
              child: Text('Notifications'),
            ),
            const PopupMenuItem<String>(
              value: 'settings',
              child: Text('Settings'),
            ),
            const PopupMenuItem<String>(
              value: 'logout',
              child: Text('Logout'),
            ),
          ],
        ),
      ],
    );
  }

  void _handleMenuSelection(String value, BuildContext context) {
    switch (value) {
      case 'profile':
        // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
        break;
      case 'notifications':
        // Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationsScreen()));
        break;
      case 'settings':
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case 'logout':
        _performLogout(context);
        break;
    }
  }

  void _performLogout(BuildContext context) async {
    final email = Hive.box('userLogin');
    await FirebaseAuth.instance.signOut();
    email.delete(1);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


