import 'package:flutter/material.dart';
import 'package:meminjam/configs/themes/theme.dart';

class HomeStatCard extends StatelessWidget {
  final String title;
  final String count;
  final Color color;
  final IconData icon;

  const HomeStatCard({
    super.key,
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: AppTypography.title.copyWith(color: Colors.white)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 8),
                Text(count, style: AppTypography.title.copyWith(color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
