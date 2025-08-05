import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nexa/core/routes/app_routes.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';
import 'package:nexa/features/product_list/presentation/controller/product_list_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';


class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListController>();
    
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.productDetail,
        arguments: product,
      ),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Favorite Button
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Container(
                            color: AppColors.background,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: AppColors.background,
                            child: Icon(
                              Icons.image_not_supported,
                              color: AppColors.textLight,
                              size: 32.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Favorite Button
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Obx(() => GestureDetector(
                        onTap: () => controller.toggleFavorite(product.id),
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            controller.isFavorite(product.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: controller.isFavorite(product.id)
                                ? AppColors.error
                                : AppColors.textLight,
                            size: 16.w,
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              
              // Product Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      
                      SizedBox(height: 4.h),
                      
                      // Rating
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: product.rating.rate,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: AppColors.warning,
                            ),
                            itemCount: 5,
                            itemSize: 12.w,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            '(${product.rating.count})',
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                      
                      Spacer(),
                      
                      // Price
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.price,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
