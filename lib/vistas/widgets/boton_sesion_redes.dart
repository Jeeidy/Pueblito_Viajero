import 'package:flutter/material.dart';
import 'package:pueblito_viajero/utils/custom/custom_colors.dart';

class BotonRedes extends StatelessWidget {
  final String text;
  final String type;
  final IconData icon;
  final VoidCallback onPressed;

  const BotonRedes({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.blueGrey, // Fixed color
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  icon,
                  color: AppColors.verdeDivertido,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}