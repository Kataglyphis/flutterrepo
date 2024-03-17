import 'package:flutter/material.dart';
import 'package:jotrockenmitlockenrepo/Decoration/decoration_helper.dart';
import 'package:jotrockenmitlockenrepo/Decoration/row_divider.dart';
import 'package:jotrockenmitlockenrepo/Media/Open/open_button.dart';

class OpenableImage extends StatefulWidget {
  const OpenableImage(
      {super.key,
      required this.displayedImage,
      this.placeholderImage = "assets/images/Summy&Thundy_compressed.png",
      this.imageCaptioning,
      this.captioningStyle,
      this.disableOpen = false});

  final String placeholderImage;
  final String displayedImage;
  final String? imageCaptioning;
  final TextStyle? captioningStyle;
  final bool disableOpen;

  @override
  State<StatefulWidget> createState() => _OpenableImageState();
}

class _OpenableImageState extends State<OpenableImage> {
  double imageWidth = 0;
  double imageHeight = 0;

  double getImageWidth(double imageWidth) {
    var currentPageWidth = MediaQuery.of(context).size.width;
    if (imageWidth < currentPageWidth) {
      return imageWidth;
    } else {
      return currentPageWidth * 0.95;
    }
  }

  @override
  Widget build(BuildContext context) {
    FadeInImage ourMainImage = FadeInImage(
      filterQuality: FilterQuality.high,
      placeholder: AssetImage(widget.placeholderImage),
      image: AssetImage(widget.displayedImage),
    );

    ourMainImage.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      setState(() {
        imageHeight = info.image.height.toDouble();
        imageWidth = info.image.width.toDouble();
        imageWidth = getImageWidth(imageWidth).toDouble();
      });
    }));

    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: imageWidth,
          ),
          child: Stack(
            children: [
              applyBoxDecoration(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: ourMainImage,
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
              if (!widget.disableOpen)
                Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OpenButton(
                        assetPath: widget.displayedImage,
                      ),
                    )),
            ],
          ),
        ),
        if (widget.imageCaptioning != null) ...[
          rowDivider,
          Text(
            widget.imageCaptioning!,
            style: (widget.captioningStyle != null)
                ? widget.captioningStyle!
                : null,
          ),
          rowDivider,
        ]
      ],
    );
  }
}