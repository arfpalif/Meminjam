import 'package:flutter/material.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class HomeQuickActionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onClick;

  const HomeQuickActionItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorStyle.neutral3,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: ColorStyle.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTypography.caption.copyWith(color: ColorStyle.primary),
        ),
      ],
    );
  }
}
