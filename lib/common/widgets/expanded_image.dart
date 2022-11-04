import 'package:flutter/widgets.dart';

class ExpandedImage extends StatelessWidget {
  const ExpandedImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Image.asset(imagePath),
    );
  }
}
