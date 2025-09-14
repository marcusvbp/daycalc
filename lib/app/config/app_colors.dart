import 'package:flutter/material.dart';

/// Configurações de cores personalizadas para o aplicativo DayCalc
class AppColors {
  // Cores do tema escuro
  static const Color darkBackground = Color(
    0xFF10141D,
  ); // Azul escuro quase preto
  static const Color darkSurface = Color(0xFF1D2433); // Cinza azulado escuro
  static const Color darkAccent = Color(0xFF4688F5); // Azul brilhante
  static const Color darkPrimaryText = Color(0xFFEBEBEB); // Branco suave
  static const Color darkSecondaryText = Color(0xFFA0A6B2); // Cinza claro

  // Cores do tema claro (baseadas em tons creme e laranja)
  static const Color lightBackground = Color(0xFFFDF8F0); // Creme pálido
  static const Color lightSurface = Color(0xFFF8EFE4); // Pêssego muito claro
  static const Color lightAccent = Color(0xFFFF9F43); // Laranja quente
  static const Color lightPrimaryText = Color(0xFF2C2C2C); // Preto
  static const Color lightSecondaryText = Color(0xFF757575); // Cinza escuro

  // Cores de estado
  static const Color success = Color(0xFF10B981); // Verde
  static const Color warning = Color(0xFFF59E0B); // Amarelo
  static const Color error = Color(0xFFEF4444); // Vermelho
  static const Color info = Color(0xFF3B82F6); // Azul info

  /// Retorna o esquema de cores para o tema escuro
  static ColorScheme get darkColorScheme {
    return const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: darkAccent,
      onPrimary: Colors.white,
      secondary: darkAccent,
      onSecondary: Colors.white,
      tertiary: darkAccent,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: darkSurface,
      onSurface: darkPrimaryText,
      surfaceContainerHighest: Color(0xFF2A3441), // Variação da superfície
      onSurfaceVariant: darkSecondaryText,
      outline: Color(0xFF475569), // Borda sutil
      outlineVariant: Color(0xFF334155), // Borda mais sutil
      shadow: Colors.black,
      scrim: Colors.black54,
      inverseSurface: lightSurface,
      onInverseSurface: lightPrimaryText,
      inversePrimary: lightAccent,
      surfaceTint: darkAccent,
    );
  }

  /// Retorna o esquema de cores para o tema claro
  static ColorScheme get lightColorScheme {
    return const ColorScheme.light(
      brightness: Brightness.light,
      primary: lightAccent,
      onPrimary: Colors.white,
      secondary: lightAccent,
      onSecondary: Colors.white,
      tertiary: lightAccent,
      onTertiary: Colors.white,
      error: error,
      onError: Colors.white,
      surface: lightSurface,
      onSurface: lightPrimaryText,
      surfaceContainerHighest: Color(
        0xFFF2E8D9,
      ), // Variação da superfície (tom mais escuro do pêssego)
      onSurfaceVariant: lightSecondaryText,
      outline: Color(0xFFD4C4B0), // Borda sutil (tom creme)
      outlineVariant: Color(0xFFE8DCC8), // Borda mais sutil (tom creme claro)
      shadow: Colors.black26,
      scrim: Colors.black54,
      inverseSurface: darkSurface,
      onInverseSurface: darkPrimaryText,
      inversePrimary: darkAccent,
      surfaceTint: lightAccent,
    );
  }

  /// Retorna o tema de texto personalizado para o tema escuro
  static TextTheme get darkTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(color: darkPrimaryText),
      displayMedium: TextStyle(color: darkPrimaryText),
      displaySmall: TextStyle(color: darkPrimaryText),
      headlineLarge: TextStyle(color: darkPrimaryText),
      headlineMedium: TextStyle(color: darkPrimaryText),
      headlineSmall: TextStyle(color: darkPrimaryText),
      titleLarge: TextStyle(color: darkPrimaryText),
      titleMedium: TextStyle(color: darkPrimaryText),
      titleSmall: TextStyle(color: darkPrimaryText),
      bodyLarge: TextStyle(color: darkPrimaryText),
      bodyMedium: TextStyle(color: darkPrimaryText),
      bodySmall: TextStyle(color: darkSecondaryText),
      labelLarge: TextStyle(color: darkPrimaryText),
      labelMedium: TextStyle(color: darkSecondaryText),
      labelSmall: TextStyle(color: darkSecondaryText),
    );
  }

  /// Retorna o tema de texto personalizado para o tema claro
  static TextTheme get lightTextTheme {
    return const TextTheme(
      displayLarge: TextStyle(color: lightPrimaryText),
      displayMedium: TextStyle(color: lightPrimaryText),
      displaySmall: TextStyle(color: lightPrimaryText),
      headlineLarge: TextStyle(color: lightPrimaryText),
      headlineMedium: TextStyle(color: lightPrimaryText),
      headlineSmall: TextStyle(color: lightPrimaryText),
      titleLarge: TextStyle(color: lightPrimaryText),
      titleMedium: TextStyle(color: lightPrimaryText),
      titleSmall: TextStyle(color: lightPrimaryText),
      bodyLarge: TextStyle(color: lightPrimaryText),
      bodyMedium: TextStyle(color: lightPrimaryText),
      bodySmall: TextStyle(color: lightSecondaryText),
      labelLarge: TextStyle(color: lightPrimaryText),
      labelMedium: TextStyle(color: lightSecondaryText),
      labelSmall: TextStyle(color: lightSecondaryText),
    );
  }
}
