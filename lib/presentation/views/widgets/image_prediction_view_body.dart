import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:connect_tenserflow/core/utils/functions/show_custom_snack_bar.dart';
import 'package:connect_tenserflow/core/utils/widgets/custom_curcular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../managers/image_prediction_cubit/image_prediction_cubit.dart';
import 'button_row.dart';
import 'image_display.dart';
import 'prediction_display.dart';

class ImagePredictionViewBody extends StatefulWidget {
  const ImagePredictionViewBody({super.key});

  @override
  State<ImagePredictionViewBody> createState() =>
      _ImagePredictionViewBodyState();
}

class _ImagePredictionViewBodyState extends State<ImagePredictionViewBody> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ImagePredictionCubit>();

    return BlocConsumer<ImagePredictionCubit, ImagePredictionState>(
      listener: (context, state) {
        _handleSnackBar(state, context);
      },
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220,
              child: ImageDisplay(imageUint8List: cubit.imageUint8List),
            ),
            ButtonRow(
              onPickFromCamera: () => cubit.pickImage(ImageSource.camera),
              onPickFromGallery: () => cubit.pickImage(ImageSource.gallery),
              onPredict: () => cubit.onPredict(context),
            ),
            Text(
              state is ImagePredictSuccess
                  ? "Your image is: ${cubit.clothesPrediction.predictionResult}"
                  : 'Not Selected',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (state is ImagePredictLoading)
              const CustomCirlcularProgressIndicator()
            else if (cubit.selectedPrediction)
              PredictionDisplay(clothesPrediction: cubit.clothesPrediction)
            else
              const Text("No prediction done yet"),
          ],
        );
      },
    );
  }

  void _handleSnackBar(ImagePredictionState state, BuildContext context) {
    if (state is ImagePickedSuccess) {
      showCustomSnackBar(context, message: "Image Picked Successfully");
    } else if (state is ImageTakenSuccess) {
      showCustomSnackBar(context, message: "Image Taken Successfully");
    } else if (state is ImagePickedFail) {
      showCustomSnackBar(context, message: "No Images Picked");
    } else if (state is ImageTakenFail) {
      showCustomSnackBar(context, message: "No Images Taken");
    } else if (state is ImagePredictFail) {
      showCustomSnackBar(context, message: "No Image Selected to predict");
    } else if (state is ImagePredictSuccess) {
      showCustomSnackBar(context, message: "Your Image is: ${state.imageType}");
    }
  }
}
