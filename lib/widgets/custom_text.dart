import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.size = 16,
    this.fontWeight = FontWeight.w500,
    this.color = Colors.black87,
    this.height = 1.3,
  }) : super(key: key);
  final String text;
  final double? size,height;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size, fontWeight: fontWeight,color: color,height: height),
    );
  }
}
