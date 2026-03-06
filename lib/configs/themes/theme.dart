import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meminjam/shared/styles/color_style.dart';

class AppTypography {
  /// Heading 1: Digunakan untuk judul utama halaman yang sangat menonjol.
  static TextStyle h1 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: ColorStyle.neutral1,
  );

  /// Heading 2: Digunakan untuk judul section atau sambutan pengguna.
  static TextStyle h2 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: ColorStyle.neutral1,
  );

  /// Heading 3: Digunakan untuk sub-judul section yang lebih kecil.
  static TextStyle h3 = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: ColorStyle.neutral1,
  );

  /// Title: Digunakan untuk label komponen atau item list yang menonjol.
  static TextStyle title = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: ColorStyle.neutral1,
  );

  /// Subtitle: Digunakan untuk deskripsi pendek atau teks informasi tambahan.
  static TextStyle subtitle = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorStyle.neutral2,
  );

  /// Caption: Digunakan untuk teks sangat kecil seperti label icon atau metadata.
  static TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: ColorStyle.neutral2,
  );
}

class AppTheme {
  static ThemeData light() {
    return ThemeData.light(useMaterial3: true).copyWith(
      primaryColor: ColorStyle.primary,
      scaffoldBackgroundColor: ColorStyle.white,
      textTheme: GoogleFonts.interTextTheme(),
    );
  }

  static ThemeData dark() {
    return ThemeData.dark(useMaterial3: true);
  }
}
