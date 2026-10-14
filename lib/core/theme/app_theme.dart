import 'package:flutter/material.dart';

const killNotifyAccent = Color(0xFF4F46E5);

class AppTheme {
  static ThemeData light({Color accentColor = killNotifyAccent}) =>
      _build(Brightness.light, accentColor: accentColor);

  static ThemeData dark({Color accentColor = killNotifyAccent}) =>
      _build(Brightness.dark, accentColor: accentColor);

  static ThemeData amoled({Color accentColor = killNotifyAccent}) =>
      _build(Brightness.dark, accentColor: accentColor, amoled: true);

  static ThemeData _build(
    Brightness brightness, {
    required Color accentColor,
    bool amoled = false,
  }) {
    final seed = ColorScheme.fromSeed(
      seedColor: accentColor,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
    );
    final scheme = seed.copyWith(
      primary: accentColor,
      onPrimary: readableForeground(accentColor),
      surface: amoled ? Colors.black : seed.surface,
      surfaceContainer: amoled
          ? const Color(0xFF0D0D0D)
          : seed.surfaceContainer,
    );
    final inputOutline = BorderSide(
      color: amoled ? const Color(0xFF626262) : scheme.outlineVariant,
    );
    final inputShape = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: inputOutline,
    );
    final inputTheme = InputDecorationTheme(
      filled: true,
      fillColor: amoled ? const Color(0xFF101010) : scheme.surfaceContainer,
      border: inputShape,
      enabledBorder: inputShape,
      disabledBorder: inputShape.copyWith(
        borderSide: inputOutline.copyWith(
          color: inputOutline.color.withValues(alpha: 0.5),
        ),
      ),
      focusedBorder: inputShape.copyWith(
        borderSide: BorderSide(color: accentColor, width: 2),
      ),
      errorBorder: inputShape.copyWith(
        borderSide: BorderSide(color: scheme.error),
      ),
      focusedErrorBorder: inputShape.copyWith(
        borderSide: BorderSide(color: scheme.error, width: 2),
      ),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: brightness,
      scaffoldBackgroundColor: amoled ? Colors.black : null,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: amoled ? Colors.black : null,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: amoled ? const Color(0xFF101010) : scheme.surfaceContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: inputTheme,
      dialogTheme: DialogThemeData(
        backgroundColor: amoled ? Colors.black : scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: amoled ? Colors.black : scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        headerBackgroundColor: amoled
            ? const Color(0xFF101010)
            : scheme.primaryContainer,
        headerForegroundColor: amoled
            ? scheme.onSurface
            : scheme.onPrimaryContainer,
        inputDecorationTheme: inputTheme,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: amoled ? Colors.black : scheme.surfaceContainerHigh,
        dialBackgroundColor: amoled
            ? const Color(0xFF101010)
            : scheme.surfaceContainerHighest,
        dialHandColor: accentColor,
        hourMinuteColor: amoled
            ? const Color(0xFF101010)
            : scheme.secondaryContainer,
        hourMinuteTextColor: scheme.onSurface,
        dayPeriodColor: amoled
            ? const Color(0xFF101010)
            : scheme.secondaryContainer,
        dayPeriodTextColor: scheme.onSurface,
        entryModeIconColor: accentColor,
        inputDecorationTheme: inputTheme,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: amoled ? Colors.black : scheme.surfaceContainerHigh,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: amoled ? Colors.black : null,
        indicatorColor: scheme.secondaryContainer,
      ),
    );
  }

  static Color readableForeground(Color background) {
    final white = _contrast(background, Colors.white);
    final black = _contrast(background, Colors.black);
    return white >= black ? Colors.white : Colors.black;
  }

  static double _contrast(Color first, Color second) {
    final a = first.computeLuminance();
    final b = second.computeLuminance();
    final lighter = a > b ? a : b;
    final darker = a > b ? b : a;
    return (lighter + 0.05) / (darker + 0.05);
  }
}
