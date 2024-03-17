// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:go_router/go_router.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlocken/Routing/router_creator.dart';

import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Routing/screen_configurations.dart';

import 'package:jotrockenmitlockenrepo/constants.dart';

import 'package:jotrockenmitlockenrepo/Routing/router_creater.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with SingleTickerProviderStateMixin {
  ThemeMode themeMode = ThemeMode.dark;
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

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: transitionLength.toInt() * 2),
      value: 0,
      vsync: this,
    );
    railAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double width = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;
    if (width > mediumWidthBreakpoint) {
      if (width > largeWidthBreakpoint) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }
    if (!controllerInitialized) {
      controllerInitialized = true;
      controller.value = width > mediumWidthBreakpoint ? 1 : 0;
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

  @override
  Widget build(BuildContext context) {
    ScreenConfigurations screenConfigurations =
        JotrockenmitLockenScreenConfigurations();
    AppAttributes appAttributes = AppAttributes(
      appTitle: 'Artificial neurons are almost magic',
      appName: "Jotrockenmitlocken",
      supportedLanguages: [
        const Locale('de'), // Deutsch
        const Locale('en'), // English
      ],
      screenConfigurations: screenConfigurations,
      railAnimation: railAnimation,
      showMediumSizeLayout: showMediumSizeLayout,
      showLargeSizeLayout: showLargeSizeLayout,
      useOtherLanguageMode: useOtherLanguageMode,
      useLightMode: useLightMode,
      colorSelected: colorSelected,
      handleBrightnessChange: handleBrightnessChange,
      handleLanguageChange: handleLanguageChange,
      handleColorSelect: handleColorSelect,
    );

    RoutesCreator routesCreator = JoTrockenMitLockenRoutesCreator();

    final GoRouter routerConfig = routesCreator.getRouterConfig(
        appAttributes,
        controller,
        JotrockenmitlockenFooter(
            footerPagesConfig:
                JotrockenmitLockenScreenConfigurations.getFooterPagesConfig()));

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: appAttributes.supportedLanguages,
      title: appAttributes.appTitle,
      themeMode: themeMode,
      theme: ThemeData(
        //fontFamily: 'Montserrat',
        colorSchemeSeed: colorSelected.color,
        colorScheme: null,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      routerConfig: routerConfig,
    );
  }
}
