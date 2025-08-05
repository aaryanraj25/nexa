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
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColors.surface,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.surface,
                          AppColors.surface.withOpacity(0.95),
                        ],
                      ),
                    ),
                  ),
                  leading: Container(
                    margin: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cardShadow,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primary,
                        size: 18.w,
                      ),
                    ),
                  ),
                  actions: [
                    Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Obx(() => IconButton(
                        onPressed: controller.toggleFavorite,
                        icon: Icon(
                          controller.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          color: controller.isFavorite.value
                              ? AppColors.favoriteActive
                              : AppColors.favoriteInactive,
                          size: 20.w,
                        ),
                      )),
                    ),
                  ],
                ),
                
                SliverToBoxAdapter(
                  child: ProductImageCarousel(
                    imageUrl: controller.product.image,
                  ),
                ),
                
                SliverToBoxAdapter(
                  child: ProductInfoCard(
                    product: controller.product,
                  ),
                ),
                
                SliverToBoxAdapter(
                  child: SizedBox(height: 120.h),
                ),
              ],
            ),
          ),
          
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.surface.withOpacity(0.0),
                  AppColors.surface.withOpacity(0.8),
                  AppColors.surface,
                ],
                stops: const [0.0, 0.3, 1.0],
              ),
            ),
            child: SafeArea(
              top: false,
              child: AddToCartButton(),
            ),
          ),
        ],
      ),
    );
  }
}