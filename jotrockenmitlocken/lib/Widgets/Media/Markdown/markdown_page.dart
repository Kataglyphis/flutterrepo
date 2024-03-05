import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/ElementBuilder/centered_image_builder.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/ElementBuilder/code_element_builder.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/ElementBuilder/latex_element_builder.dart';
import 'package:jotrockenmitlocken/Widgets/Media/Markdown/ElementBuilder/latex_inline_syntax.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter/services.dart' show rootBundle;
import 'package:jotrockenmitlockenrepo/constants.dart';

import 'ElementBuilder/centered_head_builder.dart';

class MarkdownFilePage extends StatefulWidget {
  MarkdownFilePage(
      {super.key,
      required this.filePathDe,
      required this.filePathEn,
      this.imageDirectory = 'assets/images/',
      required this.colorSelected});
  String filePathDe;
  String filePathEn;
  String imageDirectory;
  ColorSeed colorSelected;

  @override
  _MarkdownFilePage createState() => _MarkdownFilePage();
}

class _MarkdownFilePage extends State<MarkdownFilePage> {
  String _markupContent = '''''';
  @override
  void initState() {
    super.initState();
  }

  Future<void> loadMarkupFile() async {
    // Load markup file
    String markupContent = await _readMarkupFile();
    setState(() {
      _markupContent = markupContent;
    });
  }

  Future<String> _readMarkupFile() async {
    // Path to the markup file
    assert(widget.filePathDe != '' || widget.filePathEn != '',
        'You must provide at least one correct file path!');
    try {
      // Read file content
      if (Localizations.localeOf(context) == const Locale('de') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (Localizations.localeOf(context) == const Locale('de') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (Localizations.localeOf(context) == const Locale('en') &&
          widget.filePathEn != '') {
        return await rootBundle.loadString(widget.filePathEn);
      } else if (Localizations.localeOf(context) == const Locale('en') &&
          widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else if (widget.filePathDe != '') {
        return await rootBundle.loadString(widget.filePathDe);
      } else {
        return await rootBundle.loadString(widget.filePathEn);
      }
    } catch (e) {
      print("Error reading file: $e");
      return '';
    }
  }

  double getMarkdownPageWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.9;
    } else {
      return currentWidth * 0.7;
    }
  }

  @override
  Widget build(BuildContext context) {
    loadMarkupFile();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const SizedBox(height: 10),
        SizedBox(
            width: getMarkdownPageWidth(),
            child: Center(
                child: MarkdownBody(
              selectable: true,
              data: _markupContent,
              styleSheet: MarkdownStyleSheet(
                  h1: const TextStyle(fontWeight: FontWeight.bold),
                  h2: const TextStyle(fontWeight: FontWeight.bold),
                  h1Align: WrapAlignment.center,
                  //h1Padding: EdgeInsets.fromViewPadding(padding, devicePixelRatio),
                  h2Align: WrapAlignment.center,
                  img: TextStyle(fontStyle: FontStyle.italic)),
              styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
              imageDirectory: widget.imageDirectory,
              builders: <String, MarkdownElementBuilder>{
                'latex': LatexElementBuilder(
                  textScaleFactor: 1.2,
                  //textStyle: const TextStyle(color: Colors.black),
                ),
                'img': CenteredImageBuilder(
                    colorSelected: widget.colorSelected,
                    imageDir: widget.imageDirectory,
                    currentPageWidth: getMarkdownPageWidth()),
                'h1': CenteredHeaderBuilder(),
                'code': CodeElementBuilder(colorSelected: widget.colorSelected),
              },
              extensionSet: md.ExtensionSet(
                <md.BlockSyntax>[
                  ...md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                  ...md.ExtensionSet.gitHubWeb.blockSyntaxes,
                ],
                <md.InlineSyntax>[
                  md.EmojiSyntax(),
                  LatexInlineSyntax(),
                  ...md.ExtensionSet.gitHubWeb.inlineSyntaxes
                ],
              ),
            ))),
        const SizedBox(height: 10),
      ], //
    );
  }
}
