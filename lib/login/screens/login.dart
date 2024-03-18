import 'package:firebase_integration/constants/globalVariables.dart';
import 'package:firebase_integration/homescreen/screens/homescreen.dart';
import 'package:firebase_integration/login/cubit/logincubit.dart';
import 'package:firebase_integration/login/cubit/loginstate.dart';
import 'package:firebase_integration/login/cubit/otpverify.dart';
import 'package:firebase_integration/login/screens/otpverificationscreen.dart';
import 'package:firebase_integration/login/screens/signup.dart';
import 'package:firebase_integration/preferences/signupPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LoginPage> {
  final phoneNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      body: GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) async {
              if (state.status == LoginStatus.error) {
                showErrorSnackBar(context: context, message: state.errorMessage);
              }
              if (state.status == LoginStatus.success) {
                showSuccessSnackBar(
                    context: context, message: 'OTP send successfully');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return const OTPVerificationScreen();
                }));
              }
            },
            builder: (context, state) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 30),
                padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade200,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Center(
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 28),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        controller: phoneNoController,
                        style: const TextStyle(),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(10),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone_android,size: 22),
                          hintText: 'Enter phone number',
                          filled: true,
                          fillColor: Colors.purple.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    state.status == LoginStatus.loading
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              loginCubit.login(phoneNoController.text);
                            },
                            child: Container(
                              height: 40,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                color: Colors.purple.shade500,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text(
                                  'Login with OTP',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 25,
                    ),
                    Image.asset('assets/images/scorpion.jpg',
                        width: 200, height: 200),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
