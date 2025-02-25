import 'package:flutter/material.dart';
import 'widgets/image_prediction_view.dart';

void main() {
  runApp(const GuuessClothesProductApp());
}

class GuuessClothesProductApp extends StatelessWidget {
  const GuuessClothesProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImagePredictionView(),
    );
  }
}
