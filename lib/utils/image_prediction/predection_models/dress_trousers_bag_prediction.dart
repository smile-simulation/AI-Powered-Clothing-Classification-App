import 'package:connect_tenserflow/utils/image_prediction/models/prediction.dart';
import 'package:connect_tenserflow/utils/image_prediction/predection_models/clothes_prediction.dart';
import 'package:image/image.dart' as img;
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;

class DressTrousersBagPrediction extends ClothesPrediction {

  Future<Prediction> predict({required Uint8List imageUint8}) async {
    final interpreter = await Interpreter.fromAsset(
        'assets/ai_models/dress_trousers_bag_model.tflite');
    log("Model expects input shape: ${interpreter.getInputTensor(0).shape}");

    img.Image image = img.decodeImage(imageUint8)!;
    image = img.copyResize(image, width: 128, height: 128);

    Float32List input = await imageToByteListFloat32(image, 128);
    log("Input shape: ${input.length}");

    // Reshape the input to match the expected shape [1, 128, 128, 3]

    var reshapedInput = input.reshape([1, 128, 128, 3]);

    var output = List.filled(1 * 3, 0.0).reshape([1, 3]); // ضبط شكل المخرجات
    log(output.toString());

    try {
      interpreter.run(reshapedInput, output);
    } on Exception catch (e) {
      log(e.toString());
      // TODO
    }

    List<dynamic> predictionPercentages =
        (output[0] as List).map((e) => e * 100).toList();
    print("\nPrediction Probabilities:");
    print("Dress: ${predictionPercentages[0].toStringAsFixed(2)}%");
    print("Trousers: ${predictionPercentages[1].toStringAsFixed(2)}%");
    print("Bag: ${predictionPercentages[2].toStringAsFixed(2)}%");
    // log(getPredictionResult(predictionPercentages));
    Prediction prediction = Prediction();
    prediction.predictionResult = getPredictionResult(predictionPercentages);
    prediction.predictionValues = predictionPercentages;
    prediction.lables = ["Dress", "Trousers", "Bag"];
    return prediction;
  }
}
