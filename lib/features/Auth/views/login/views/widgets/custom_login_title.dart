import 'package:flutter/material.dart';

class CustomLoginTitle extends StatelessWidget {
  const CustomLoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 50),
      child: const Text(
        "Login to Your Account",
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
