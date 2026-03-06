import 'package:flutter/material.dart';
import 'package:meminjam/shared/styles/color_style.dart';

Widget menuItems(IconData icon, String title) {
  return Container(
    margin: const EdgeInsets.only(bottom: 4),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: ColorStyle.neutral1, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: ColorStyle.neutral1),
      ),
      trailing: const Icon(Icons.chevron_right, color: ColorStyle.neutral2),
      onTap: () {},
    ),
  );
}
