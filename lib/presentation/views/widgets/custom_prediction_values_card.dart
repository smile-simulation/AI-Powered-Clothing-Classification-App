import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:connect_tenserflow/core/utils/clothes_classification/models/prediction_model.dart';
import 'package:flutter/material.dart';

class CustomPredictionValuesCard extends StatelessWidget {
  const CustomPredictionValuesCard({
    super.key,
    required this.prediction,
    required this.predictionModel,
  });
  final String predictionModel;
  final PredictionModel prediction;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  predictionModel,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Spacer(),
                Text(
                    "Result: ${prediction.lables![prediction.predictionResult!]}"),
                for (int i = 0; i < 3; i++)
                  Text(
                    "${prediction.lables?[i] ?? 'not set'}: ${double.tryParse(prediction.predictionValues?[i].toStringAsFixed(2)) ?? 'not set'} %",
                  ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
