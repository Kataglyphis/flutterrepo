import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jotrockenmitlocken/DocumentPage/document.dart';
import 'package:jotrockenmitlocken/constants.dart';
import 'package:jotrockenmitlocken/font_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'download_stub.dart' if (dart.library.html) 'download_web.dart';

@immutable
class DownloadButton extends StatelessWidget {
  Document document;
  DownloadButton({
    super.key,
    required this.document,
  });

  void _onPressed() async {
    myPluginDownload(baseDocumentDir + document.title);
    if (kIsWeb) {
      //String url = baseDocumentDir + document.title;
      //html.window.open(url, "_blank");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).primaryColor;
    return ElevatedButton(
      onPressed: _onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      ),
      child: Text(
        "Open",
        style: FontHelper.getTextStyleSubHeadings(context),
      ),
    );
  }
}
