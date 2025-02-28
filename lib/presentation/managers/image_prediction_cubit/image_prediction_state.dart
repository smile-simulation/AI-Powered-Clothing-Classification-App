part of 'image_prediction_cubit.dart';

sealed class ImagePredictionState {}

final class ImagePredictionInitial extends ImagePredictionState {}

final class ImagePickedSuccess extends ImagePredictionState {}

final class ImageTakenSuccess extends ImagePredictionState {}

final class ImagePickedFail extends ImagePredictionState {}

final class ImageTakenFail extends ImagePredictionState {}

final class ImagePredictLoading extends ImagePredictionState {}

final class ImagePredictSuccess extends ImagePredictionState {
  final String imageType;

  ImagePredictSuccess({required this.imageType});
}

final class ImagePredictFail extends ImagePredictionState {}
