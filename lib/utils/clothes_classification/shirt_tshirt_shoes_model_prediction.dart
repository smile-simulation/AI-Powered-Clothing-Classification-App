import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'models/prediction.dart';
import 'base_clothes_prediction.dart';

class ShirtTshirtShoesModelPrediction extends BaseClothesPrediction {
  Future<Prediction> predict({required Uint8List imageUint8}) {
    return loadAndRunModel(
      modelPath: 'assets/ai_models/model_STSH.tflite',
      imageUint8: imageUint8,
      inputSize: 224,
      labels: ["T-Shirt", "Shirt", "Shoes"],
    );
  }
}
