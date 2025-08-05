import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:nexa/features/cart/data/model/cart_item_model.dart';
import 'package:nexa/features/cart/presentation/controller/cart_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class CartItemCard extends StatelessWidget {
  final CartItemModel cartItem;

  const CartItemCard({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CartController>();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: cartItem.product.image,
                fit: BoxFit.contain,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                    strokeWidth: 2,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.image_not_supported,
                  color: AppColors.textLight,
                ),
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product.title,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                
                SizedBox(height: 4.h),
                
                Text(
                  '\$${cartItem.product.price.toStringAsFixed(2)}',
                  style: AppTextStyles.price.copyWith(fontSize: 16.sp),
                ),
                
                SizedBox(height: 8.h),
                
                // Quantity Controls
                Row(
                  children: [
                    // Decrease Button
                    GestureDetector(
                      onTap: () => controller.updateQuantity(
                        cartItem.product.id,
                        cartItem.quantity - 1,
                      ),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Icon(
                          Icons.remove,
                          size: 16.w,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    
                    SizedBox(width: 12.w),
                    
                    Text(
                      '${cartItem.quantity}',
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    
                    SizedBox(width: 12.w),
                    
                    // Increase Button
                    GestureDetector(
                      onTap: () => controller.updateQuantity(
                        cartItem.product.id,
                        cartItem.quantity + 1,
                      ),
                      child: Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 16.w,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    
                    Spacer(),
                    
                    // Remove Button
                    GestureDetector(
                      onTap: () => controller.removeFromCart(cartItem.product.id),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          size: 20.w,
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
