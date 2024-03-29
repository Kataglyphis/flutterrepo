import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Pages/Footer/footer.dart';
import 'package:jotrockenmitlockenrepo/Layout/ResponsiveDesign/single_page.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file_table.dart';
import 'package:jotrockenmitlockenrepo/Media/Markdown/markdown_page.dart';
import 'package:jotrockenmitlockenrepo/Pages/blog_page_config.dart';
import 'package:jotrockenmitlockenrepo/app_attributes.dart';

class BlogPage extends StatefulWidget {
  final AppAttributes appAttributes;
  final Footer footer;
  final BlogPageConfig blogPageConfig;
  BlogPage(
      {required this.appAttributes,
      required this.footer,
      required this.blogPageConfig});

  @override
  State<StatefulWidget> createState() => BlogPageState();
}

class BlogPageState extends State<BlogPage> {
  @override
  Widget build(BuildContext context) {
    List<File> docs = widget.blogPageConfig
        .getDocsDesc()
        .map(
          (fileConfig) => File(
            baseDir: fileConfig['baseDir']!,
            title: fileConfig['title']!,
            additionalInfo: fileConfig['additionalInfo']!,
          ),
        )
        .toList();
    return SinglePage(
        children: [
          MarkdownFilePage(
            currentLocale: Localizations.localeOf(context),
            filePathDe: widget.blogPageConfig.getFilePathDe(),
            filePathEn: widget.blogPageConfig.getFilePathEn(),
            imageDirectory: widget.blogPageConfig.getImageDirectory(),
            useLightMode: widget.appAttributes.useLightMode,
          ),
          FileTable(
            title: 'Appendix',
            docs: docs,
          )
        ],
        footer: widget.footer,
        showMediumSizeLayout: widget.appAttributes.showMediumSizeLayout,
        showLargeSizeLayout: widget.appAttributes.showLargeSizeLayout);
  }
}
