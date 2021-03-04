import 'package:flutter/material.dart';
import 'package:image_fade/image_fade.dart';

class FadeImageWidget extends StatelessWidget {
  final Image image;
  final double width;
  final double height;
  final BoxFit fit;

  const FadeImageWidget({@required this.image, this.width, this.height, this.fit = BoxFit.fill});

  @override
  Widget build(BuildContext context) {
    return ImageFade(
      image: this.image.image,
      width: width,
      height: height,
      fit: this.fit,
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent event) {
        if (event == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
              value: event.expectedTotalBytes == null ? 0.0 : event.cumulativeBytesLoaded / event.expectedTotalBytes),
        );
      },
      errorBuilder: (BuildContext context, Widget child, dynamic exception) {
        return Container(
          height: height,
          width: width,
          color: Color(0xFF6F6D6A),
          child: Column(
            children: [Center(child: Icon(Icons.warning, color: Colors.black26, size: 128.0)), Text(exception.toString())],
          ),
        );
      },
    );
  }
}
