import 'package:flutter/material.dart';
import 'package:meminjam/configs/themes/theme.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class HomeActivityItem extends StatelessWidget {
  final String title;
  final String desc;
  final String date;
  final String time;
  final IconData icon;

  const HomeActivityItem({
    super.key,
    required this.title,
    required this.desc,
    required this.date,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorStyle.neutral3,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: ColorStyle.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTypography.title.copyWith(fontSize: 14)),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: AppTypography.subtitle.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date, style: AppTypography.caption),
                    Text(time, style: AppTypography.caption),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
