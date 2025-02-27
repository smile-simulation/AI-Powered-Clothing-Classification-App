import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'models/prediction_model.dart';
import 'base_clothes_prediction.dart';

class DressTrousersBagPrediction extends BaseClothesPrediction {
  Future<PredictionModel> predict({required Uint8List imageUint8}) {
    return loadAndRunModel(
      modelPath: 'assets/ai_models/dress_trousers_bag_model.tflite',
      imageUint8: imageUint8,
      inputSize: 128,
      labels: ["Dress", "Trousers", "Bag"],
    );
  }
}
