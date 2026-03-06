import 'package:flutter/material.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class DeactiveBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final List<Color>? gradientColors;
  final double borderRadius;
  final double height;
  final TextStyle? textStyle;

  const DeactiveBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.gradientColors,
    required this.borderRadius,
    required this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = gradientColors ?? [ColorStyle.neutral3, ColorStyle.neutral3];
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool bounded = constraints.hasBoundedWidth;
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            width: bounded ? double.infinity : null,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                splashColor: Colors.white24,
                highlightColor: Colors.white10,
                child: Container(
                  height: height,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    text,
                    style: TextStyle(color: ColorStyle.neutral2),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
