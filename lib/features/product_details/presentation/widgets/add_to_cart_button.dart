import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/cart/presentation/controller/cart_controller.dart';
import 'package:nexa/features/product_details/presentation/controller/product_detail_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductDetailController>();
    final cartController = Get.find<CartController>();
    
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
            Obx(() {
              final isInCart = cartController.isProductInCart(productController.product.id);
              final quantity = cartController.getProductQuantity(productController.product.id);
              
              return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: isInCart 
                          ? () => cartController.removeFromCart(productController.product.id)
                          : null,
                      icon: Icon(
                        Icons.remove,
                        color: isInCart ? AppColors.textSecondary : AppColors.textSecondary.withOpacity(0.5),
                        size: 20.w,
                      ),
                    ),
                    Text(
                      isInCart ? '$quantity' : '1',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: isInCart 
                          ? () => cartController.addToCart(productController.product)
                          : null,
                      icon: Icon(
                        Icons.add,
                        color: isInCart ? AppColors.textSecondary : AppColors.textSecondary.withOpacity(0.5),
                        size: 20.w,
                      ),
                    ),
                  ],
                ),
              );
            }),
            
            SizedBox(width: 16.w),
            
            Expanded(
              child: Obx(() {
                final isInCart = cartController.isProductInCart(productController.product.id);
                final quantity = cartController.getProductQuantity(productController.product.id);
                
                return ElevatedButton(
                  onPressed: () {
                    if (!isInCart) {
                      cartController.addToCart(productController.product);
                      Get.snackbar(
                        'Added to Cart',
                        '${productController.product.title} has been added to your cart',
                        backgroundColor: AppColors.success.withOpacity(0.9),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: const Duration(seconds: 2),
                        margin: EdgeInsets.all(16.w),
                        borderRadius: 12.r,
                        icon: Icon(
                          Icons.check_circle_outline,
                          color: Colors.white,
                          size: 24.w,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInCart 
                        ? AppColors.success 
                        : AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    isInCart 
                        ? '$quantity in Cart' 
                        : AppStrings.addToCart,
                    style: AppTextStyles.button,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}