import 'package:connect_tenserflow/core/utils/app_colors.dart';
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
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.whiteColor,
          ),
          onPressed: onPredict,
          child: Row(
            children: [
              const Icon(Icons.smart_toy),
              SizedBox(
                width: 4,
              ),
              Text('Predict'),
            ],
          ),
        ),
      ],
    );
  }
}
