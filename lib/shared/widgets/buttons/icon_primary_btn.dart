import 'package:flutter/material.dart';

class IconPrimaryBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;

  const IconPrimaryBtn({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: textColor),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
