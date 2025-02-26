import 'dart:typed_data';

import 'package:connect_tenserflow/utils/image_prediction/models/prediction.dart';
import 'package:connect_tenserflow/utils/image_prediction/predection_models/clothes_prediction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/image_prediction/predection_models/shirt_tshirt_shoes_model_prediction.dart';
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
  bool isBaherModel = false;
  Prediction? selectedPrediction;
  ShirtTshirtShoesModelPrediction baherPrediction =
      ShirtTshirtShoesModelPrediction();
  ShirtTshirtShoesModelPrediction asmaaPrediction =
      ShirtTshirtShoesModelPrediction();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageXFile = pickedFile;
      });
      convertFromFileToImage();
    }
  }

  Future<void> convertFromFileToImage() async {
    if (imageXFile != null) {
      imageUint8List = await imageXFile!.readAsBytes();
      setState(() {});
    }
  }

  Future<void> predictImageType() async {
    if (imageXFile != null) {
      baherPrediction.prediction = await baherPrediction.predict(
        imageUint8: await imageXFile!.readAsBytes(),
      );
      asmaaPrediction.prediction = await asmaaPrediction.predict(
        imageUint8: await imageXFile!.readAsBytes(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Prediction Done",
          ),
        ),
      );
      // imageType = prediction.predictionResult!;
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "No image selected",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
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
                onPredict: predictImageType,
              ),
              Text(
                "Your image is: ${ClothesPrediction().getFinalResultPrediction(
                      firstPrediction: baherPrediction.prediction,
                      secondPrediction: asmaaPrediction.prediction,
                    ) ?? 'Not Selected'}",
              ),
              selectedPrediction != null
                  ? PredictionDisplay(
                      baherPrediction: baherPrediction.prediction,
                      asmaaPrediction: asmaaPrediction.prediction,
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
}
