import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class GlobalVariables {

}
void showSuccessSnackBar({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      backgroundColor: Colors.green,
      content: Text(
        message ?? '',
        style: const TextStyle(),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
void showErrorSnackBar({required BuildContext context, String? message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      backgroundColor: Colors.redAccent,
      content: Text(
        message ?? 'Invalid data',
        style: const TextStyle(),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

