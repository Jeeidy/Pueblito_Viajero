import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TextFieldNombreMirador extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;

  const TextFieldNombreMirador({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: kIsWeb ? 40 : 60,
          width: keyboardType == TextInputType.datetime ? 60 : null,
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
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(color: Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.only(left: 8, bottom: kIsWeb ? 5 : 0),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black38, fontSize: kIsWeb ? null : 18),
            ),
          ),
        ),
      ],
    );
  }
}

class TextFieldDescripcionMirador extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldDescripcionMirador({
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

class TextFieldServiciosMirador extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldServiciosMirador({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
  });

  @override
  _TextFieldServiciosMiradorState createState() => _TextFieldServiciosMiradorState();
}

class _TextFieldServiciosMiradorState extends State<TextFieldServiciosMirador> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkMaxLines);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkMaxLines);
    super.dispose();
  }

  void _checkMaxLines() {
    final lines = widget.controller.text.split('\n').length;
    if (lines > 10) {
      final newText = widget.controller.text.split('\n').take(10).join('\n');
      widget.controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220,
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
              Expanded(
                child: TextField(
                  maxLines: 9,
                  focusNode: widget.focusNode,
                  controller: widget.controller,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.only(top: 10, left: 8, bottom: 10),
                    hintText: widget.hintText,
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
