import 'package:connect_tenserflow/utils/image_prediction/models/prediction.dart';
import 'package:connect_tenserflow/utils/image_prediction/predection_models/clothes_prediction.dart';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

// import 'package:flutter/services.dart' show rootBundle;

class DressTrousersBagPrediction extends ClothesPrediction {

  Future<Prediction> predict({required Uint8List imageUint8}) {
    return loadAndRunModel(
      modelPath: 'assets/ai_models/dress_trousers_bag_model.tflite',
      imageUint8: imageUint8,
      inputSize: 128,
      labels: ["Dress", "Trousers", "Bag"],
    );
  }
}
