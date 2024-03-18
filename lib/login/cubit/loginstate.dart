import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  error,
}

class LoginState extends Equatable {
  final String phoneNo;
  final String otp;
  final LoginStatus status;
  final String? errorMessage;
  final String? otpSuccess;
  final bool? verifyOtp;
  final User? user;

  const LoginState(
      {required this.phoneNo,
      required this.status,
      this.user,
      required this.otp,
      this.errorMessage,
      this.otpSuccess,
      this.verifyOtp});

  @override
  List<Object?> get props =>
      [phoneNo, status, user, errorMessage, otp, otpSuccess, verifyOtp];

  LoginState copyWith(
      {String? phoneNo,
      LoginStatus? status,
        User? user,
      String? errorMessage,
      String? otp,
      String? otpSuccess,
      bool? verifyOtp}) {
    return LoginState(
        phoneNo: phoneNo ?? this.phoneNo,
        status: status ?? this.status,
        user: user ?? this.user,
        errorMessage: errorMessage,
        otp: otp ?? this.otp,
        otpSuccess: otpSuccess ?? this.otpSuccess,
        verifyOtp: verifyOtp ?? this.verifyOtp);
  }
}
