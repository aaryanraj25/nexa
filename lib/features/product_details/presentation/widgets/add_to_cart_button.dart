import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/product_details/presentation/controller/product_detail_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Quantity Selector
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: controller.decrementQuantity,
                    icon: Icon(
                      Icons.remove,
                      color: AppColors.textSecondary,
                      size: 20.w,
                    ),
                  ),
                  Obx(() => Text(
                    '${controller.quantity.value}',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  )),
                  IconButton(
                    onPressed: controller.incrementQuantity,
                    icon: Icon(
                      Icons.add,
                      color: AppColors.textSecondary,
                      size: 20.w,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Add to Cart Button
            Expanded(
              child: Obx(() => ElevatedButton(
                onPressed: controller.addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isInCart 
                      ? AppColors.success 
                      : AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  controller.isInCart 
                      ? 'Added to Cart' 
                      : AppStrings.addToCart,
                  style: AppTextStyles.button,
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
