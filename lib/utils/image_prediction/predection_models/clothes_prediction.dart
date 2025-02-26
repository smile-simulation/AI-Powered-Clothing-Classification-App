import 'dart:typed_data';

import 'package:image/image.dart' as img;

import '../models/prediction.dart';

class ClothesPrediction {
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

  String? getFinalResultPrediction({
    required Prediction? firstPrediction,
    required Prediction? secondPrediction,
  }) {
    if (firstPrediction == null || secondPrediction == null) {
      return null;
    }
    if (firstPrediction.predictionValues![firstPrediction.predictionResult!] <
            90 &&
        secondPrediction.predictionValues![secondPrediction.predictionResult!] <
            90) {
      return "no valid clothes";
    }
    if (firstPrediction.predictionValues![firstPrediction.predictionResult!] >
        secondPrediction
            .predictionValues![secondPrediction.predictionResult!]) {
      return firstPrediction.lables![firstPrediction.predictionResult!];
    } else {
      return secondPrediction.lables![secondPrediction.predictionResult!];
    }
  }
}
