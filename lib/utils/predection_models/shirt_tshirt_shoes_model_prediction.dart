import 'package:image/image.dart' as img;
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';

import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:flutter/services.dart' show rootBundle;

class ShirtTshirtShoesModelPrediction {
  // Future<img.Image> loadImageFromAssets(String path) async {
  //   ByteData data = await rootBundle.load(path);
  //   Uint8List bytes = data.buffer.asUint8List();
  //   return img.decodeImage(bytes)!;
  // }

  Future<String> predict({required Uint8List imageUint8}) async {
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
    return getPredictionResult(predictionPercentages);
  }

  String getPredictionResult(List<dynamic> predictionPercentages) {
    // Define the labels corresponding to the output indices
    List<String> labels = ["T-Shirt", "Shirt", "Shoes"];

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
    return labels[maxIndex];
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
