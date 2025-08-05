import 'package:flutter/material.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive_helper.dart';
import '../../../../core/utils/size_config.dart';
import '../../../../core/widgets/custom_loading.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductModel> products;

  const ProductGrid({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          height: 200.h,
          child: Center(
            child: Text(
              'No products found',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.getCrossAxisCount(context),
          childAspectRatio: 0.75,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCard(product: products[index]);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}

class ProductGridLoading extends StatelessWidget {
  const ProductGridLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.getCrossAxisCount(context),
          childAspectRatio: 0.75,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductCardShimmer();
          },
          childCount: 6,
        ),
      ),
    );
  }
}
