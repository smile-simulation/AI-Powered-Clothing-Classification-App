import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showCustomSnackBar(
  BuildContext context, {
  required String message,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Durations.extralong4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      closeIconColor: AppColors.whiteColor,
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    ),
  );
}
