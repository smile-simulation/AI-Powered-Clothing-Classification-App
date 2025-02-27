
import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final Uint8List? imageUint8List;

  const ImageDisplay({super.key, this.imageUint8List});

  @override
  Widget build(BuildContext context) {
    return imageUint8List != null
        ? Image.memory(imageUint8List!)
        : Image.asset("assets/images/image_holder.jpeg");
  }
}
