import 'package:flutter/material.dart';

const String appTitle = 'Artificial neurons are almost magic';

// NavigationRail shows if the screen width is greater or equal to
// narrowScreenWidthThreshold; otherwise, NavigationBar is used for navigation.
const double narrowScreenWidthThreshold = 450;

const double mediumWidthBreakpoint = 1000;
const double largeWidthBreakpoint = 1500;

const double transitionLength = 500;

const appName = "Jotrockenmitlocken";

enum ColorSeed {
  baseColor('Green Accent', Colors.greenAccent),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  const ColorSeed(this.label, this.color);
  final String label;
  final Color color;
}

const supportedLanguages = [
  Locale('de'), // Deutsch
  Locale('en'), // English
];

const baseDocumentDir = 'https://www.jonasheinle.de/assets/assets/documents/';
