import 'package:firebase_integration/constants/globalVariables.dart';
import 'package:firebase_integration/login/cubit/logincubit.dart';
import 'package:firebase_integration/login/cubit/loginstate.dart';
import 'package:firebase_integration/login/screens/login.dart';
import 'package:firebase_integration/login/screens/otpverificationscreen.dart';
import 'package:firebase_integration/login/screens/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignupPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showErrorSnackBar(context: context, message: state.errorMessage);
            }
            if (state.status == LoginStatus.success) {
              showSuccessSnackBar(
                  context: context, message: 'OTP send successfully');
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OTPVerificationScreen();
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
                      'Sign Up',
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: userNameController,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: emailController,
                    style: const TextStyle(),
                    decoration: InputDecoration(
                      hintText: 'Enter mail',
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passController,
                    decoration: InputDecoration(
                      hintText: 'Enter password',
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number',
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  state.status == LoginStatus.loading
                      ? CircularProgressIndicator(
                          color: Colors.purple.shade100,
                        )
                      : GestureDetector(
                          onTap: () {
                            // loginCubit.signUp(emailController.text,
                            //     passController.text, mobileController.text);
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.purple.shade500,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?' '  '),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LoginPage();
                            }));
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.purple.shade500),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Icon(
                    Icons.adb,
                    color: Colors.green,
                    size: 100,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
