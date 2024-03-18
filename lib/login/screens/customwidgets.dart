import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    if (newValue.text.length > 1) {
      return const TextEditingValue().copyWith(
          text: newValue.text.substring(0, 1));
    }
    return newValue;
  }
}

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({super.key,this.unFocus, required this.controller});
  final String? unFocus;
  final TextEditingController controller;

  @override
  RoundedTextFieldState createState() => RoundedTextFieldState();
}

class RoundedTextFieldState extends State<RoundedTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    widget.controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly, OTPTextInputFormatter()],
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            widget.unFocus != null ? FocusScope.of(context).unfocus() :
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

