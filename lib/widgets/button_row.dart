
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  final VoidCallback onPickFromCamera;
  final VoidCallback onPickFromGallery;
  final VoidCallback onPredict;

  const ButtonRow({
    super.key,
    required this.onPickFromCamera,
    required this.onPickFromGallery,
    required this.onPredict,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPickFromCamera,
          icon: const Icon(Icons.camera),
        ),
        IconButton(
          onPressed: onPickFromGallery,
          icon: const Icon(Icons.photo),
        ),
        IconButton(
          onPressed: onPredict,
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
