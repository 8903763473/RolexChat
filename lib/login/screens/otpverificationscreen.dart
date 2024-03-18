import 'package:firebase_integration/constants/globalVariables.dart';
import 'package:firebase_integration/homescreen/screens/homescreen.dart';
import 'package:firebase_integration/login/cubit/logincubit.dart';
import 'package:firebase_integration/login/cubit/loginstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'customwidgets.dart';

class OTPVerificationScreen extends StatefulWidget {

  const OTPVerificationScreen(
      {Key? key})
      : super(key: key);

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController otpController1 = TextEditingController();
  final TextEditingController otpController2 = TextEditingController();
  final TextEditingController otpController3 = TextEditingController();
  final TextEditingController otpController4 = TextEditingController();
  final TextEditingController otpController5 = TextEditingController();
  final TextEditingController otpController6 = TextEditingController();

  final _userLogin = Hive.box('userLogin');

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.grey.shade200,
        title: const Text('OTP Verification'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == LoginStatus.error) {
              showErrorSnackBar(context: context, message: state.errorMessage);
            }
            if (state.verifyOtp == true &&
                state.status == LoginStatus.success) {
              _userLogin.put(1, state.user);
              showSuccessSnackBar(
                  context: context, message: 'Logged in Successfully');
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return HomeScreen(userName: state.user?.phoneNumber ?? '');
              }));
            }
          },
          builder: (context, state) {
            return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RoundedTextField(controller: otpController1),
                            const SizedBox(width: 10),
                            RoundedTextField(controller: otpController2),
                            const SizedBox(width: 10),
                            RoundedTextField(controller: otpController3),
                            const SizedBox(width: 10),
                            RoundedTextField(controller: otpController4),
                            const SizedBox(width: 10),
                            RoundedTextField(controller: otpController5),
                            const SizedBox(width: 10),
                            RoundedTextField(
                                unFocus: 'true', controller: otpController6),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'If you are not got OTP?  ',
                              style: TextStyle(),
                            ),
                            GestureDetector(
                                onTap: () {},
                                child: const Text(
                                  'Resend',
                                  style: TextStyle(color: Colors.purple),
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        state.status == LoginStatus.loading
                            ? CircularProgressIndicator(
                                color: Colors.purple.shade200,
                              )
                            : GestureDetector(
                                onTap: () async {
                                  await loginCubit.verifyOtp(
                                      getOtp());
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.purple.shade500,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 20),
                                    child: Text(
                                      'Verify OTP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }

  String getOtp() {
    return otpController1.text +
        otpController2.text +
        otpController3.text +
        otpController4.text +
        otpController5.text +
        otpController6.text;
  }

  // Widget center(BuildContext context) {
  //   final loginCubit = context.read<LoginCubit>();
  //   final mobileController = TextEditingController();
  //   return Center(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         SizedBox(
  //           width: MediaQuery.of(context).size.width * 0.7,
  //           child: Expanded(
  //             child: TextField(
  //               controller: mobileController,
  //               keyboardType: TextInputType.phone,
  //               inputFormatters: [
  //                 LengthLimitingTextInputFormatter(10),
  //                 FilteringTextInputFormatter.digitsOnly,
  //               ],
  //               decoration: InputDecoration(
  //                 hintText: 'Enter your mobile number',
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(10),
  //                   borderSide: BorderSide.none,
  //                 ),
  //                 filled: true,
  //                 fillColor: Colors.purple.shade100,
  //               ),
  //             ),
  //           ),
  //         ),
  //         const SizedBox(height: 20),
  //         GestureDetector(
  //           onTap: () {
  //             if (mobileController.text.length == 10) {
  //               // loginCubit.sendOtp(mobileController.text);
  //             } else {
  //               showErrorSnackBar(
  //                   context: context, message: 'Invalid phone number');
  //             }
  //           },
  //           child: loginCubit.state.status == LoginStatus.loading
  //               ? CircularProgressIndicator(
  //                   color: Colors.purple.shade300,
  //                 )
  //               : Container(
  //                   width: MediaQuery.of(context).size.width * 0.4,
  //                   decoration: BoxDecoration(
  //                     color: Colors.purple.shade500,
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: const Padding(
  //                     padding:
  //                         EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
  //                     child: Center(
  //                       child: Text(
  //                         'Send OTP',
  //                         style: TextStyle(color: Colors.white),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
