import 'dart:math';

Future<String> generateNumericOTP(int length) async {
  const digits = '0123456789';
  String otp = '';
  Random random = Random();
  for (int i = 0; i < length; i++) {
    int randomIndex = random.nextInt(digits.length);
    otp += digits[randomIndex];
  }
  return otp;
}