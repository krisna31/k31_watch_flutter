import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

final myTextTheme = TextTheme(
  headlineSmall: GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 22,
    letterSpacing: 0.20,
  ),
  titleLarge: GoogleFonts.poppins(
    fontWeight: FontWeight.w400,
    fontSize: 18,
  ),
  titleMedium: GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 13,
    letterSpacing: 0.15,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontWeight: FontWeight.w300,
    fontSize: 12,
    letterSpacing: 0.22,
  ),
);

const Color primary = Color.fromARGB(228, 65, 65, 65);
const Color darkBlue = Color.fromARGB(228, 10, 46, 86);
const Color success = Color.fromARGB(255, 6, 65, 120);
const Color warning = Color.fromARGB(255, 225, 177, 18);
const Color lightGray = Color.fromARGB(255, 87, 99, 106);
const Color darkGray = Color.fromARGB(255, 39, 37, 37);

const k31ColorScheme = ColorScheme(
  primary: warning,
  primaryContainer: warning,
  secondary: success,
  secondaryContainer: success,
  surface: primary,
  background: primary,
  error: Colors.red,
  onPrimary: primary,
  onSurface: Colors.white,
  onSecondary: Colors.white,
  onBackground: Colors.white,
  onError: Colors.blue,
  brightness: Brightness.dark,
);
