import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlocken/Pages/ErrorPage/error_page_widget.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class ErrorPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    return LayoutManager.createSinglePage(
        [
          const ErrorPageWidget(),
        ],
        Footer(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
          footerConfig: appAttributes.footerConfig,
        ),
        appAttributes.showMediumSizeLayout,
        appAttributes.showLargeSizeLayout);
  }
}
