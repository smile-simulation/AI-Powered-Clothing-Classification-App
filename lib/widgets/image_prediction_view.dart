
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/predection_models/shirt_tshirt_shoes_model_prediction.dart';
import 'button_row.dart';
import 'image_display.dart';

class ImagePredictionView extends StatefulWidget {
  const ImagePredictionView({super.key});

  @override
  State<ImagePredictionView> createState() => _ImagePredictionViewState();
}

class _ImagePredictionViewState extends State<ImagePredictionView> {
  XFile? imageXFile;
  Uint8List? imageUint8List;
  String imageType = "No Image Selected";

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
      imageType = await ShirtTshirtShoesModelPrediction().predict(
        imageUint8: await imageXFile!.readAsBytes(),
      );
      setState(() {});
    } else {
      log("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ImageDisplay(imageUint8List: imageUint8List),
            ButtonRow(
              onPickFromCamera: () => pickImage(ImageSource.camera),
              onPickFromGallery: () => pickImage(ImageSource.gallery),
              onPredict: predictImageType,
            ),
            Text("Your image is: $imageType"),
          ],
        ),
      ),
    );
  }
}
