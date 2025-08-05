import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/routes/app_routes.dart';
import 'package:nexa/features/cart/presentation/controller/cart_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          AppStrings.cart,
          style: AppTextStyles.heading2,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.textPrimary,
            size: 20.w,
          ),
        ),
        actions: [
          Obx(() => controller.cartItems.isNotEmpty
              ? TextButton(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        title: Text('Clear Cart'),
                        content: Text('Are you sure you want to clear your cart?'),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.clearCart();
                              Get.back();
                            },
                            child: Text('Clear'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Text(
                    'Clear All',
                    style: TextStyle(color: AppColors.error),
                  ),
                )
              : SizedBox.shrink()),
        ],
      ),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 80.w,
                  color: AppColors.textLight,
                ),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.emptyCart,
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () => Get.offAllNamed(AppRoutes.productList),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.continueShopping,
                    style: AppTextStyles.button,
                  ),
                ),
              ],
            ),
          );
        }
        
        return Column(
          children: [
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  return CartItemCard(
                    cartItem: controller.cartItems[index],
                  );
                },
              ),
            ),
            
            // Cart Summary
            CartSummary(),
          ],
        );
      }),
    );
  }
}
