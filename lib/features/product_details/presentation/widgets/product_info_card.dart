import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductModel product;

  const ProductInfoCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Title
          Text(
            product.title,
            style: AppTextStyles.heading3,
          ),
          
          SizedBox(height: 8.h),
          
          // Category
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              product.category.toUpperCase(),
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          SizedBox(height: 12.h),
          
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
                itemSize: 20.w,
                direction: Axis.horizontal,
              ),
              SizedBox(width: 8.w),
              Text(
                '${product.rating.rate} (${product.rating.count} reviews)',
                style: AppTextStyles.bodyMedium,
              ),
            ],
          ),
          
          SizedBox(height: 16.h),
          
          // Price
          Text(
            '\$${product.price.toStringAsFixed(2)}',
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.primary,
            ),
          ),
          
          SizedBox(height: 16.h),
          
          // Description
          Text(
            'Description',
            style: AppTextStyles.heading3.copyWith(
              fontSize: 18.sp,
            ),
          ),
          
          SizedBox(height: 8.h),
          
          Text(
            product.description,
            style: AppTextStyles.bodyLarge.copyWith(
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
