import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlocken/Pages/blog_pages_config.dart';
import 'package:jotrockenmitlockenrepo/Pages/navbar_pages_factory.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';

class LandingPage extends NavBarPagesFactory {
  List<List<Widget>> _createLandingPageChildWidgets(
      AppAttributes appAttributes, BuildContext context) {
    const colDivider = SizedBox(height: 10);
    List<Widget> childWidgetsLeftPage = [];
    List<Widget> childWidgetsRightPage = [];
    List<BlogPagesConfig> blogPagesConfig =
        JotrockenmitLockenScreenConfigurations.getBlogPagesConfig();

    for (int i = 0; i < blogPagesConfig.length; i++) {
      if (blogPagesConfig[i].landingPageAlignment ==
          LandingPageAlignment.left) {
        childWidgetsLeftPage += [
          colDivider,
          blogPagesConfig[i]
              .landingPageEntryFactory
              .createLandingPageEntry(appAttributes, context),
          colDivider,
        ];
      } else {
        childWidgetsRightPage += [
          colDivider,
          blogPagesConfig[i]
              .landingPageEntryFactory
              .createLandingPageEntry(appAttributes, context),
          colDivider,
        ];
      }
    }
    return [childWidgetsLeftPage, childWidgetsRightPage];
  }

  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    var homePagesLeftRight =
        _createLandingPageChildWidgets(appAttributes, context);
    return LayoutManager.createOneTwoTransisionWidget(
        homePagesLeftRight[0],
        homePagesLeftRight[1],
        JotrockenmitlockenFooter(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
        ),
        appAttributes.showMediumSizeLayout,
        appAttributes.showLargeSizeLayout,
        appAttributes.railAnimation);
  }

  @override
  NavigationDestination getNavigationDestination(BuildContext context) {
    return NavigationDestination(
      tooltip: '',
      icon: const Icon(Icons.house_outlined),
      label: AppLocalizations.of(context)!.homepage,
      selectedIcon: const Icon(Icons.house),
    );
  }
}
