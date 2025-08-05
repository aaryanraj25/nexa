import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/product_list/presentation/controller/product_list_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListController>();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: controller.searchProducts,
        decoration: InputDecoration(
          hintText: AppStrings.searchProducts,
          hintStyle: AppTextStyles.bodyMedium,
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.textLight,
            size: 20.w,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        style: AppTextStyles.bodyLarge,
      ),
    );
  }
}
