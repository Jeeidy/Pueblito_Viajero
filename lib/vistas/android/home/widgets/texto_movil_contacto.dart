import 'package:flutter/material.dart';

class TextoMovilContacto extends StatelessWidget {
  final String dato;
  final String texto;
  final Icon icono;
  const TextoMovilContacto({super.key, required this.dato, required this.texto, required this.icono});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        icono,
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              texto,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              dato,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}
