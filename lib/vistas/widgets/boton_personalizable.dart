import 'package:flutter/material.dart';

class BotonComun extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const BotonComun({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

class BotonComunIcono extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onPressed;
  final Icon icono;

  const BotonComunIcono({
    super.key,
    required this.color,
    required this.text,
    required this.onPressed,
    required this.icono,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: color,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(width: 13),
            icono
          ],
        ),
      ),
    );
  }
}