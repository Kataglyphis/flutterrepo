// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

import 'package:jotrockenmitlocken/app_frame.dart';
import 'package:jotrockenmitlocken/navigation_state.dart';

import 'constants.dart';

void main() {
  //usePathUrlStrategy();
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;
  bool useOtherLanguageMode = false;

  bool get useLightMode {
    switch (themeMode) {
      case ThemeMode.system:
        return View.of(context).platformDispatcher.platformBrightness ==
            Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  void handleBrightnessChange(bool useLightMode) {
    setState(() {
      themeMode = useLightMode ? ThemeMode.light : ThemeMode.dark;
    });
  }

  void handleLanguageChange() {
    setState(() {
      useOtherLanguageMode = useOtherLanguageMode ? false : true;
    });
  }

  void handleColorSelect(int value) {
    setState(() {
      colorSelected = ColorSeed.values[value];
    });
  }

  NavigationState navigationState = NavigationState(
      screenIndex: ScreenSelected.documents.value,
      screenIndexNonNavBar: NonNavBarScreenSelected.imprint.value,
      nonNavBarScreenSelected: false);

  @override
  Widget build(BuildContext context) {
    return AppFrame(
        useLightMode: useLightMode,
        useOtherLanguageMode: useOtherLanguageMode,
        handleBrightnessChange: handleBrightnessChange,
        handleLanguageChange: handleLanguageChange,
        handleColorSelect: handleColorSelect,
        colorSelected: colorSelected,
        themeMode: themeMode);

    // home: SelectionArea(
    //     child: Home(
    //   useLightMode: useLightMode,
    //   useOtherLanguageMode: useOtherLanguageMode,
    //   handleBrightnessChange: handleBrightnessChange,
    //   handleLanguageChange: handleLanguageChange,
    //   handleColorSelect: handleColorSelect,
    //   colorSelected: colorSelected,
    // )));
  }
}
