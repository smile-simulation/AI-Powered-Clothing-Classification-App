import 'package:connect_tenserflow/utils/models/prediction.dart';
import 'package:image/image.dart' as img;
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;

class DressTrousersBagPrediction {
  // Future<img.Image> loadImageFromAssets(String path) async {
  //   ByteData data = await rootBundle.load(path);
  //   Uint8List bytes = data.buffer.asUint8List();
  //   return img.decodeImage(bytes)!;
  // }

  Future<Prediction> predict({required Uint8List imageUint8}) async {
    final interpreter = await Interpreter.fromAsset(
        'assets/ai_models/dress_trousers_bag_model.tflite');
    log("Model expects input shape: ${interpreter.getInputTensor(0).shape}");

    // String imagePath = 'assets/images/shoes.jpeg';
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

  int getPredictionResult(List<dynamic> predictionPercentages) {
    // Define the labels corresponding to the output indices
    List<String> labels = ["Dress", "Trousers", "Bag"];

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

  // Convert image to Float32List for TensorFlow Lite model input
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
}
