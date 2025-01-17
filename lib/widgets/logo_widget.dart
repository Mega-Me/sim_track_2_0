import 'package:flutter/material.dart';

// Logo Widget
class LogoWidget extends StatelessWidget {
  final String imagePath;
  final String title;

  const LogoWidget({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.white10,
          backgroundImage: AssetImage(imagePath),
          radius: size.height * 0.12,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}