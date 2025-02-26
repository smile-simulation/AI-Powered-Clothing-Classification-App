import 'package:connect_tenserflow/utils/clothes_classification/clothes_prediction.dart';
import 'package:flutter/material.dart';

import 'custom_prediction_values_card.dart';

class PredictionDisplay extends StatelessWidget {
  const PredictionDisplay({
    super.key,
    required this.clothesPrediction,
  });

  final ClothesPrediction clothesPrediction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CustomPredictionValuesCard(
            prediction: clothesPrediction.baherPrediction.prediction!,
            predictionModel: 'shirt, T-shirt, shoes Prediction',
          ),
          SizedBox(
            height: 16,
          ),
          CustomPredictionValuesCard(
            prediction: clothesPrediction.asmaaPrediction.prediction!,
            predictionModel: 'dress, trousers, bag Prediction',
          )
        ],
      ),
    );
  }
}
