import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:connect_tenserflow/presentation/managers/image_prediction_cubit/image_prediction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/image_prediction_view_body.dart';

class ImagePredictionView extends StatefulWidget {
  const ImagePredictionView({super.key});

  @override
  State<ImagePredictionView> createState() => _ImagePredictionViewState();
}

class _ImagePredictionViewState extends State<ImagePredictionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.whiteColor,
        title: Text("AI powered Clothes classification"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider(
            create: (context) => ImagePredictionCubit(),
            child: ImagePredictionViewBody(),
          ),
        ),
      ),
    );
  }
}
