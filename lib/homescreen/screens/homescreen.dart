import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_integration/homescreen/screens/customAppbar.dart';
import 'package:firebase_integration/login/screens/login.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Welcome $userName'),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
