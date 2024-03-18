import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'loginstate.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit()
      : super(const LoginState(
            phoneNo: '',
            status: LoginStatus.initial,
            otp: '',
            otpSuccess: 'fail',
            verifyOtp: false));
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  void setLoading() {
    emit(state.copyWith(status: LoginStatus.loading));
  }

  void setError({String? message}) {
    emit(state.copyWith(status: LoginStatus.error, errorMessage: message));
  }

  Future<void> login(String phoneNo) async {
    setLoading();
    try {
      if (phoneNo.length != 10) {
        return setError(message: 'Enter valid mobile number');
      } else if (phoneNo != '') {
        await _auth.verifyPhoneNumber(
          phoneNumber: '+91$phoneNo',
          verificationCompleted: (credential) async {
            await _auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            if (e.code == 'invalid-phone-number') {
              return setError(message: 'Invalid phone number');
            } else {
              return setError(message: 'Something went wrong. Try again.');
            }
          },
          codeSent: (verificationId, resendToken) {
            emit(state.copyWith(
                otpSuccess: 'success',
                status: LoginStatus.success,
                otp: verificationId));
          },
          codeAutoRetrievalTimeout: (verificationId) {
            // const Duration timeoutDuration = Duration(seconds: 30);
            emit(state.copyWith(
                otpSuccess: 'success',
                status: LoginStatus.success,
                otp: verificationId));
          },
        );
      }
      // await _auth.createUserWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );
      // emit(state.copyWith(status: LoginStatus.success));
    } catch (e) {
      return setError(message: 'The email address is already in use');
    }
  }

  Future<void> verifyOtp(String getOtp) async {
    setLoading();
    try {
      if (getOtp.length != 6) {
        return setError(message: 'OTP field is Empty');
      }
      var credentials = await _auth.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: state.otp, smsCode: getOtp));
      var otpDone = credentials.user != null ? true : false;
      emit(state.copyWith(
          user: credentials.user,
          verifyOtp: otpDone,
          status: LoginStatus.success));
    } catch (e) {
      return setError(message: 'Invalid OTP');
    }
  }
  //
  // Future<void> sendOtp(String phoneNo) async {
  //   setLoading();
  //   try {
  //     if (phoneNo.length != 10) {
  //       return setError(message: 'Enter valid mobile number');
  //     } else if (phoneNo != '') {
  //       await _auth.verifyPhoneNumber(
  //         phoneNumber: '+91$phoneNo',
  //         verificationCompleted: (credential) async {
  //           await _auth.signInWithCredential(credential);
  //         },
  //         verificationFailed: (e) {
  //           if (e.code == 'invalid-phone-number') {
  //             return setError(message: 'Invalid phone number');
  //           } else {
  //             return setError(message: 'Something went wrong. Try again.');
  //           }
  //         },
  //         codeSent: (verificationId, resendToken) {
  //           emit(state.copyWith(
  //               otpSuccess: 'success',
  //               status: LoginStatus.success,
  //               otp: verificationId));
  //         },
  //         codeAutoRetrievalTimeout: (verificationId) {
  //           emit(state.copyWith(
  //               otpSuccess: 'success',
  //               status: LoginStatus.success,
  //               otp: verificationId));
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     return setError(message: 'Invalid mobile number');
  //   }
  // }

  // Future<String> sendEmail(String mail) async {
  //   final smtpServer = gmail('muthuselvanmuthu17@gmail.com', '9344013294');
  //
  //   final otp = await generateNumericOTP(4);
  //
  //   final message = Message()
  //     ..from = const Address('muthuselvanmuthu17@gmail.com', 'RolexChat')
  //     ..recipients.add(mail)
  //     ..subject = 'OTP from RolexChat'
  //     ..text = 'Your OTP is: $otp';
  //   emit(state.copyWith(otp: otp));
  //   try {
  //     final sendReport = await send(message, smtpServer);
  //     return otp;
  //   } catch (e) {
  //     throw Exception("Error in sending OTP Email");
  //   }
  // }

  bool _validateEmailAndPass(String email, String pass) {
    return email.isNotEmpty &&
        pass.isNotEmpty &&
        (pass.length >= 8 && pass.length <= 12) &&
        email.contains('@gmail.');
  }
}
