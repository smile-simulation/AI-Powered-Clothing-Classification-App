
import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../managers/image_prediction_cubit/image_prediction_cubit.dart';

class CustomPredictButtonBuilder extends StatelessWidget {
  const CustomPredictButtonBuilder({
    super.key,
    required this.onPredict,
  });

  final VoidCallback onPredict;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePredictionCubit, ImagePredictionState>(
      builder: (context, state) {
        return state is ImagePredictLoading
            ? SizedBox()
            : TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: AppColors.whiteColor,
                ),
                onPressed: onPredict,
                child: Row(
                  children: [
                    const Icon(Icons.smart_toy),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Predict'),
                  ],
                ),
              );
      },
    );
  }
}
