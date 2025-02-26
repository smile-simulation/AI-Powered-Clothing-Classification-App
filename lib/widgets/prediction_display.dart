
import 'package:connect_tenserflow/utils/image_prediction/models/prediction.dart';
import 'package:flutter/material.dart';

import 'custom_prediction_values_card.dart';

class PredictionDisplay extends StatelessWidget {
  const PredictionDisplay({
    super.key,
    required this.baherPrediction,
    required this.asmaaPrediction,
  });

  final Prediction? baherPrediction;
  final Prediction? asmaaPrediction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          baherPrediction != null
              ? CustomPredictionValuesCard(
                  prediction: baherPrediction!,
                  predictionModel: 'shirt, T-shirt, shoes Prediction',
                )
              : SizedBox(),
          SizedBox(
            height: 16,
          ),
          asmaaPrediction != null
              ? CustomPredictionValuesCard(
                  prediction: asmaaPrediction!,
                  predictionModel: 'dress, trousers, bag',
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
