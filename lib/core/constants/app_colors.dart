import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1A365D);
  static const Color primaryLight = Color(0xFF2D3748);
  static const Color primaryDark = Color(0xFF0F1419); 
  static const Color secondary = Color(0xFFD69E2E);
  static const Color accent = Color(0xFFED8936); 
  static const Color accentLight = Color(0xFFFBD38D); 
  static const Color background = Color(0xFFFAFAFA); 
  static const Color surface = Colors.white;
  static const Color surfaceElevated = Color(0xFFF7FAFC);
  static const Color error = Color(0xFFE53E3E); 
  static const Color success = Color(0xFF38A169);
  static const Color warning = Color(0xFFD69E2E);
  static const Color info = Color(0xFF3182CE); 
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textLight = Color(0xFF718096);
  static const Color textMuted = Color(0xFFA0AEC0);
  static const Color border = Color(0xFFE2E8F0);
  static const Color borderLight = Color(0xFFF1F5F9);
  static const Color shadow = Color(0x1A1A365D);
  static const Color overlay = Color(0x4D1A365D);
  static const Color cardBackground = Colors.white;
  static const Color cardShadow = Color(0x0A1A365D);
  static const Color favoriteActive = Color(0xFFE53E3E);
  static const Color favoriteInactive = Color(0xFF718096);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1A365D), Color(0xFF2D3748)],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Color(0xFFF7FAFC)],
  );
}