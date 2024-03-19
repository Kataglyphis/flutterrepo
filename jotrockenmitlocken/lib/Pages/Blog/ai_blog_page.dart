import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/Pages/Footer/jotrockenmitlocken_footer.dart';
import 'package:jotrockenmitlockenrepo/Pages/LandingPage/landig_page_entry.dart';
import 'package:jotrockenmitlocken/Pages/jotrockenmitlocken_screen_configurations.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/layout_manager.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';
import 'package:jotrockenmitlockenrepo/Pages/pages_factory.dart';

class AiBlogPage extends PagesFactory {
  @override
  Widget createPage(AppAttributes appAttributes, BuildContext context) {
    List<File> docs = [
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_english.pdf',
        additionalInfo: '~3.7MB English',
      ),
      File(
        baseDir: 'assets/documents/',
        title: 'CV_Jonas_Heinle_german.pdf',
        additionalInfo: '~3.7MB German',
      ),
      File(
          baseDir: 'assets/images/',
          title: 'WorleyNoiseTextures.zip',
          additionalInfo: 'Use it for you own projects.')
    ];
    return LayoutManager.createSinglePage(
        [
          MarkdownFilePage(
            filePathDe: '',
            filePathEn: 'assets/documents/blog/aiBlogPageEn.md',
            imageDirectory: 'assets/images/aiBlog',
            useLightMode: appAttributes.useLightMode,
          ),
          FileTable(
            title: 'Appendix',
            docs: docs,
          )
        ],
        JotrockenmitlockenFooter(
          footerPagesConfig:
              JotrockenmitLockenScreenConfigurations.getFooterPagesConfig(),
          userSettings: appAttributes.userSettings,
        ),
        appAttributes.showMediumSizeLayout,
        appAttributes.showLargeSizeLayout);
  }
}
