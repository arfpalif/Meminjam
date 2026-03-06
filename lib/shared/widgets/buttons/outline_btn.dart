import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class OutlineBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final double borderRadius;
  final double height;
  final String? image;
  final TextStyle? textStyle;

  const OutlineBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradientColors,
    required this.borderRadius,
    required this.height,
    this.image,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: image != null ? SvgPicture.asset(image!, height: 24) : null,
        label: Text(
          text,
          style: TextStyle(
            color: ColorStyle.neutral1,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: ColorStyle.neutral3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
    );
  }
}
