import 'dart:typed_data';

import 'package:connect_tenserflow/utils/app_colors.dart';
import 'package:connect_tenserflow/utils/clothes_classification/clothes_prediction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'button_row.dart';
import 'image_display.dart';
import 'prediction_display.dart';

class ImagePredictionView extends StatefulWidget {
  const ImagePredictionView({super.key});

  @override
  State<ImagePredictionView> createState() => _ImagePredictionViewState();
}

class _ImagePredictionViewState extends State<ImagePredictionView> {
  XFile? imageXFile;
  Uint8List? imageUint8List;
  String imageType = "No Image Selected";
  bool selectedPrediction = false;
  ImagePicker imagePicker = ImagePicker();
  ClothesPrediction clothesPrediction = ClothesPrediction();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 220,
                child: ImageDisplay(
                  imageUint8List: imageUint8List,
                ),
              ),
              ButtonRow(
                onPickFromCamera: () => pickImage(ImageSource.camera),
                onPickFromGallery: () => pickImage(ImageSource.gallery),
                onPredict: () => onPredict(context),
              ),
              Text(
                "Your image is: ${ClothesPrediction().getFinalResultPrediction(
                      firstPrediction:
                          clothesPrediction.baherPrediction.prediction,
                      secondPrediction:
                          clothesPrediction.asmaaPrediction.prediction,
                    ) ?? 'Not Selected'}",
              ),
              selectedPrediction
                  ? PredictionDisplay(
                      clothesPrediction: clothesPrediction,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No prediction done yet",
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  resetImagePickers() {
    selectedPrediction = false;
    imageXFile = null;
    imageUint8List = null;
    imageType = "No Image Selected";
    clothesPrediction.asmaaPrediction.prediction = null;
    clothesPrediction.baherPrediction.prediction = null;
  }

  Future<void> pickImage(ImageSource source) async {
    resetImagePickers();
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      imageXFile = pickedFile;
      await convertFromFileToImage();
    }
    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No Image Selected",
          ),
        ),
      );
    }
    setState(() {});
  }

  Future<void> convertFromFileToImage() async {
    if (imageXFile != null) {
      imageUint8List = await imageXFile!.readAsBytes();
    }
  }

  Future<void> onPredict(BuildContext context) async {
    {
      if (imageXFile != null) {
        clothesPrediction.predictImageType(await imageXFile!.readAsBytes());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Prediction Done",
            ),
          ),
        );
        selectedPrediction = true;
        setState(() {});
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "No Image Selected",
            ),
          ),
        );
      }
    }
  }
}
