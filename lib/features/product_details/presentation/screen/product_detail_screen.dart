import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/product_details/presentation/controller/product_detail_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/size_config.dart';
import '../widgets/add_to_cart_button.dart';
import '../widgets/product_image_carousel.dart';
import '../widgets/product_info_card.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductDetailController>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                // App Bar with Back Button
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColors.surface,
                  leading: IconButton(
                    onPressed: () => Get.back(),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textPrimary,
                      size: 20.w,
                    ),
                  ),
                  actions: [
                    Obx(() => IconButton(
                      onPressed: controller.toggleFavorite,
                      icon: Icon(
                        controller.isFavorite.value
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: controller.isFavorite.value
                            ? AppColors.error
                            : AppColors.textSecondary,
                        size: 24.w,
                      ),
                    )),
                  ],
                ),
                
                // Product Image
                SliverToBoxAdapter(
                  child: ProductImageCarousel(
                    imageUrl: controller.product.image,
                  ),
                ),
                
                // Product Info
                SliverToBoxAdapter(
                  child: ProductInfoCard(
                    product: controller.product,
                  ),
                ),
                
                // Bottom Spacing
                SliverToBoxAdapter(
                  child: SizedBox(height: 100.h),
                ),
              ],
            ),
          ),
          
          // Add to Cart Button
          AddToCartButton(),
        ],
      ),
    );
  }
}
