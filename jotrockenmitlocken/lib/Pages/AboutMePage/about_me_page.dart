import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/about_me_table.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/perfect_day_chart.dart';
import 'package:jotrockenmitlocken/Pages/AboutMePage/Widgets/skill_table.dart';
import 'package:jotrockenmitlocken/Layout/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/app_frame_attributes.dart';
import 'package:jotrockenmitlocken/Pages/nav_bar_pages_factory.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutMePage extends NavBarPagesFactory {
  List<List<Widget>> _createAboutMeChildPages(
      bool useOtherLanguageMode, ColorSeed colorSelected) {
    List<Widget> childWidgetsLeftPage = [
      AboutMeTable(useOtherLanguageMode: useOtherLanguageMode),
    ];
    List<Widget> childWidgetsRightPage = [
      const PerfectDay(),
      const SizedBox(
        height: 40,
      ),
      SkillTable(
        useOtherLanguageMode: useOtherLanguageMode,
      ),
    ];

    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget createPage(AppFrameAttributes appFrameAttributes) {
    var aboutMePagesLeftRight = _createAboutMeChildPages(
        appFrameAttributes.useOtherLanguageMode,
        appFrameAttributes.colorSelected);
    return LayoutManager.createOneTwoTransisionWidget(
        aboutMePagesLeftRight[0],
        aboutMePagesLeftRight[1],
        appFrameAttributes.showMediumSizeLayout,
        appFrameAttributes.showLargeSizeLayout,
        appFrameAttributes.railAnimation);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.person_outlined),
      label: AppLocalizations.of(context)!.aboutme,
      selectedIcon: const Icon(Icons.person),
    );
  }
}