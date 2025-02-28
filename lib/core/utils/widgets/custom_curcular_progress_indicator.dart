
import 'package:connect_tenserflow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCirlcularProgressIndicator extends StatelessWidget {
  const CustomCirlcularProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        backgroundColor: AppColors.primaryColor,
        color: AppColors.whiteColor,
      ),
    );
  }
}
