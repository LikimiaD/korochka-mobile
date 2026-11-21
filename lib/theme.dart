import 'package:material_ui/material_ui.dart';

class AppColors {
  static const primary = Color(0xFF2B2A27);
  static const onPrimary = Color(0xFFFFFFFF);
  static const accent = Color(0xFFD05D07);
  static const background = Color(0xFFFFFFFF);
  static const surface = Color(0xFFFFFFFF);
  static const text = Color(0xFF2B2A27);
  static const textMuted = Color(0xFF7A776F);
  static const outline = Color(0xFFE6E4DF);
  static const error = Color(0xFFC62828);
  static const statusCreated = Color(0xFF1565C0);
  static const statusInProgress = Color(0xFFEF6C00);
  static const statusReady = Color(0xFF2E7D32);
  static const statusCompleted = Color(0xFF616161);
  static const statusCancelled = Color(0xFFC62828);
}

class AppSpacing {
  static const double xs = 4;
  static const double s = 8;
  static const double m = 12;
  static const double l = 16;
  static const double xl = 24;
}

ThemeData buildAppTheme() {
  const buttonShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.onPrimary,
      secondary: AppColors.primary,
      onSecondary: AppColors.onPrimary,
      surface: AppColors.surface,
      onSurface: AppColors.text,
      onSurfaceVariant: AppColors.textMuted,
      outline: AppColors.outline,
      outlineVariant: AppColors.outline,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.background,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(shape: buttonShape),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(shape: buttonShape),
    ),
  );
}
