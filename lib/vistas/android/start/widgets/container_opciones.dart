import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerOpciones extends StatelessWidget {
  final String text;
  final String imagePath;

  const ContainerOpciones({
    super.key,
    required this.text,
    required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4), // Adjust the opacity as needed
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          Center(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: 2,
                height: 1.03,
              ),
            ),
          ),
        ],
      ),
    );
  }
}