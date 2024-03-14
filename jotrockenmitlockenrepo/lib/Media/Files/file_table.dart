import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Media/Download/download_file_icon.dart';
import 'package:jotrockenmitlockenrepo/Media/Files/file.dart';
import 'package:jotrockenmitlockenrepo/Media/Open/open_button.dart';
import 'package:jotrockenmitlockenrepo/constants.dart';

abstract class FileTable extends StatefulWidget {
  final List<File> docs;

  const FileTable({
    super.key,
    required this.docs,
  });
}

abstract class FileTableState extends State<FileTable> {
  @override
  void initState() {
    super.initState();
  }

  String getTitle();

  double getDocumentTableWidth() {
    var currentWidth = MediaQuery.of(context).size.width;
    if (currentWidth <= narrowScreenWidthThreshold) {
      return currentWidth * 0.9;
    } else if (currentWidth <= mediumWidthBreakpoint) {
      return currentWidth * 0.9;
    } else {
      return currentWidth * 0.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    var currentWidth = MediaQuery.of(context).size.width;
    // mobile version
    var tablePadding = 0.0;
    if (currentWidth <= narrowScreenWidthThreshold) {
      tablePadding = 0.9;
    } else if (currentWidth <= largeWidthBreakpoint) {
      tablePadding = 8;
    } else {
      tablePadding = 8;
    }
    var colDivider = const SizedBox(height: 10);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          colDivider,
          Text(
            getTitle(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          colDivider,
          SizedBox(
            width: getDocumentTableWidth(),
            child: applyBoxDecoration(
                child: Column(
                    children: List.generate(widget.docs.length,
                        (index) => _buildListItem(context, index),
                        growable: true)),
                insets: EdgeInsets.all(tablePadding),
                borderRadius: 8,
                borderWidth: 4,
                color: Theme.of(context).colorScheme.primary),
          ),
        ]);
  }

  Widget _buildListItem(BuildContext context, int index) {
    File currentDocument = widget.docs.elementAt(index);
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        child: ListTile(
          leading: FileDownloadIcon(document: currentDocument),
          title: Text(
            currentDocument.title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Text(
            currentDocument.additionalInfo,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          trailing: OpenButton(
            assetPath: currentDocument.baseDir + currentDocument.title,
          ),
        ));
  }
}
