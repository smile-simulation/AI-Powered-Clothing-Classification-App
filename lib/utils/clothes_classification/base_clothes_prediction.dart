import 'dart:developer';
import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import 'models/prediction.dart';

abstract class BaseClothesPrediction {
  Prediction? prediction;

  int getPredictionResult(List<dynamic> predictionPercentages) {
    // Find the index of the highest probability
    int maxIndex = 0;
    double maxProbability = predictionPercentages[0];

    for (int i = 1; i < predictionPercentages.length; i++) {
      if (predictionPercentages[i] > maxProbability) {
        maxProbability = predictionPercentages[i];
        maxIndex = i;
      }
    }
    // Return the label with the highest probability
    return maxIndex;
  }

  Future<Float32List> imageToByteListFloat32(
      img.Image image, int inputSize) async {
    var convertedBytes = Float32List(inputSize * inputSize * 3);
    int pixelIndex = 0;

    for (int y = 0; y < inputSize; y++) {
      for (int x = 0; x < inputSize; x++) {
        final pixel = image.getPixel(x, y);

        int r = pixel.r.toInt();
        int g = pixel.g.toInt();
        int b = pixel.b.toInt();

        convertedBytes[pixelIndex++] = r / 255.0;
        convertedBytes[pixelIndex++] = g / 255.0;
        convertedBytes[pixelIndex++] = b / 255.0;
      }
    }

    return convertedBytes;
  }

  

  Future<Prediction> loadAndRunModel({
    required String modelPath,
    required Uint8List imageUint8,
    required int inputSize,
    required List<String> labels,
  }) async {
    final interpreter = await Interpreter.fromAsset(modelPath);
    log("Model expects input shape: ${interpreter.getInputTensor(0).shape}");

    img.Image image = img.decodeImage(imageUint8)!;
    image = img.copyResize(image, width: inputSize, height: inputSize);

    Float32List input = await imageToByteListFloat32(image, inputSize);
    var reshapedInput = input.reshape([1, inputSize, inputSize, 3]);
    var output =
        List.filled(1 * labels.length, 0.0).reshape([1, labels.length]);

    interpreter.run(reshapedInput, output);
    interpreter.close(); // Free memory

    List<dynamic> predictionPercentages =
        (output[0] as List).map((e) => e * 100).toList();
    log("Prediction Probabilities: $predictionPercentages");

    return Prediction()
      ..predictionResult = getPredictionResult(predictionPercentages)
      ..predictionValues = predictionPercentages
      ..lables = labels;
  }
}
