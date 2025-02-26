import 'package:connect_tenserflow/utils/image_prediction/predection_models/clothes_prediction.dart';
import 'package:image/image.dart' as img;
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:tflite_flutter/tflite_flutter.dart';

import '../models/prediction.dart';
// import 'package:flutter/services.dart' show rootBundle;

class ShirtTshirtShoesModelPrediction extends ClothesPrediction {
  // Future<img.Image> loadImageFromAssets(String path) async {
  //   ByteData data = await rootBundle.load(path);
  //   Uint8List bytes = data.buffer.asUint8List();
  //   return img.decodeImage(bytes)!;
  // }

  Future<Prediction> predict({required Uint8List imageUint8}) async {
    final interpreter =
        await Interpreter.fromAsset('assets/ai_models/model_STSH.tflite');
    log("Model expects input shape: ${interpreter.getInputTensor(0).shape}");

    // String imagePath = 'assets/images/shoes.jpeg';
    img.Image image = img.decodeImage(imageUint8)!;
    image = img.copyResize(image, width: 224, height: 224);

    Float32List input = await imageToByteListFloat32(image, 224);
    log("Input shape: ${input.length}");

    // Reshape the input to match the expected shape [1, 224, 224, 3]
    var inputBuffer = input.buffer;
    var reshapedInput = Float32List.view(inputBuffer, 0, 1 * 224 * 224 * 3)
        .reshape([1, 224, 224, 3]);

    var output = List.filled(1 * 3, 0.0).reshape([1, 3]); // ضبط شكل المخرجات

    interpreter.run(reshapedInput, output);

    List<dynamic> predictionPercentages =
        (output[0] as List).map((e) => e * 100).toList();
    print("\nPrediction Probabilities:");
    print("T-Shirt: ${predictionPercentages[0].toStringAsFixed(2)}%");
    print("Shirt: ${predictionPercentages[1].toStringAsFixed(2)}%");
    print("Shoes: ${predictionPercentages[2].toStringAsFixed(2)}%");
    // log(getPredictionResult(predictionPercentages));
    Prediction prediction = Prediction();
    prediction.predictionResult = getPredictionResult(predictionPercentages);
    prediction.predictionValues = predictionPercentages;
    prediction.lables = ["T-Shirt", "Shirt", "Shoes"];
    return prediction;
  }




  // Convert image to Float32List for TensorFlow Lite model input
  
}
