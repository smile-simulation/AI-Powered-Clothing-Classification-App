import 'package:connect_tenserflow/utils/image_prediction/predection_models/clothes_prediction.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import '../models/prediction.dart';

class ShirtTshirtShoesModelPrediction extends ClothesPrediction {
  Future<Prediction> predict({required Uint8List imageUint8}) {
    return loadAndRunModel(
      modelPath: 'assets/ai_models/model_STSH.tflite',
      imageUint8: imageUint8,
      inputSize: 224,
      labels: ["T-Shirt", "Shirt", "Shoes"],
    );
  }
}
