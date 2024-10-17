import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldDescripcion extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldDescripcion({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Container(
          height: 65,
          alignment: Alignment.topCenter,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8,left: 8),
                child: Icon(Icons.chrome_reader_mode_outlined, color: kIsWeb ? Colors.black : Colors.grey[400]),
              ),
              Expanded(
                child: TextField(
                  maxLines: 2,
                  focusNode: focusNode,
                  controller: controller,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 13, left: 8),
                    hintText: hintText,
                    hintStyle: const TextStyle(color: Colors.black38),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}