import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldPersonalizable extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String keyboard;
  final FocusNode focusNode;
  final String type;

  const TextFieldPersonalizable({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.controller,
    required this.keyboard,
    required this.focusNode,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        type == '1' ? Text(
          labelText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ) : const SizedBox(height: 0),
        const SizedBox(height: 10),
        Container(
          height: type == '1' ? 60 : 40,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            focusNode: focusNode,
            obscureText: keyboard == 'password' ? true : false,
            controller: controller,
            keyboardType:
            keyboard == 'email'
            ? TextInputType.emailAddress : keyboard == 'password'
            ? TextInputType.emailAddress : keyboard == 'num'
            ? TextInputType.number : TextInputType.text,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: type == '1' ? 14 : 9),
              prefixIcon: Icon(icon, color: kIsWeb ? Colors.black :Colors.grey[400]),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38),
            ),
          ),
        ),
      ],
    );
  }
}