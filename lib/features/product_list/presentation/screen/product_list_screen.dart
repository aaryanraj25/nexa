import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/core/routes/app_routes.dart';
import 'package:nexa/features/cart/presentation/controller/cart_controller.dart';
import 'package:nexa/features/product_list/presentation/controller/product_list_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_error.dart';
import '../widgets/product_grid.dart';
import '../widgets/search_bar.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.find<ProductListController>();
    final cartController = Get.find<CartController>();
    
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.surface,
            title: Text(
              AppStrings.appName,
              style: AppTextStyles.heading2.copyWith(
                color: AppColors.primary,
              ),
            ),
            actions: [
              // Cart Icon with Badge
              Obx(() => Stack(
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed(AppRoutes.cart),
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: AppColors.primary,
                      size: 24.w,
                    ),
                  ),
                  if (cartController.itemCount > 0)
                    Positioned(
                      right: 8.w,
                      top: 8.h,
                      child: Container(
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16.w,
                          minHeight: 16.w,
                        ),
                        child: Text(
                          '${cartController.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              )),
              SizedBox(width: 8.w),
            ],
          ),
          
          // Search Bar
          SliverToBoxAdapter(
            child: CustomSearchBar(),
          ),
          
          // Products Grid
          Obx(() {
            if (productController.isLoading.value) {
              return ProductGridLoading();
            }
            
            if (productController.errorMessage.isNotEmpty) {
              return SliverToBoxAdapter(
                child: CustomError(
                  message: productController.errorMessage.value,
                  onRetry: productController.retryFetch,
                ),
              );
            }
            
            return ProductGrid(
              products: productController.filteredProducts,
            );
          }),
          
          // Bottom Spacing
          SliverToBoxAdapter(
            child: SizedBox(height: 20.h),
          ),
        ],
      ),
    );
  }
}
