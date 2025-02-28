import 'dart:typed_data';

import 'package:connect_tenserflow/core/utils/clothes_classification/clothes_prediction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'image_prediction_state.dart';

class ImagePredictionCubit extends Cubit<ImagePredictionState> {
  ImagePredictionCubit() : super(ImagePredictionInitial());
  XFile? imageXFile;
  Uint8List? imageUint8List;
  ImagePicker imagePicker = ImagePicker();

  _resetImagePickers() {
    selectedPrediction = false;
    imageXFile = null;
    imageUint8List = null;
    imageType = "No Image Selected";
    clothesPrediction.dressTrousersBagPrediction.prediction = null;
    clothesPrediction.shirtTshirtShoesPrediction.prediction = null;
  }

  Future<void> pickImage(ImageSource source) async {
    _resetImagePickers();
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      imageXFile = pickedFile;
      await _convertFromFileToImage();
      if (source == ImageSource.camera) {
        emit(ImageTakenSuccess());
      } else if (source == ImageSource.gallery) {
        emit(ImagePickedSuccess());
      }
    } else {
      if (source == ImageSource.camera) {
        emit(ImageTakenFail());
      } else if (source == ImageSource.gallery) {
        emit(ImagePickedFail());
      }
    }
  }

  Future<void> _convertFromFileToImage() async {
    if (imageXFile != null) {
      imageUint8List = await imageXFile!.readAsBytes();
    }
  }

  String imageType = "No Image Selected";
  bool selectedPrediction = false;
  ClothesPrediction clothesPrediction = ClothesPrediction();

  Future<void> onPredict(BuildContext context) async {
    {
      emit(ImagePredictLoading());
      if (imageXFile != null) {
        await clothesPrediction
            .predictImageType(await imageXFile!.readAsBytes());
        imageType = clothesPrediction.predictionResult!;
        emit(ImagePredictSuccess(imageType: imageType));
        selectedPrediction = true;
      } else {
        emit(ImagePredictFail());
      }
    }
  }
}
