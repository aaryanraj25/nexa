import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/product_list/presentation/controller/product_list_controller.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/utils/size_config.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  
  @override
  void initState() {
    super.initState();
    final controller = Get.find<ProductListController>();
    _searchController.text = controller.searchQuery.value;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductListController>();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        onChanged: (value) {
          controller.searchProducts(value);
        },
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search products...',
          hintStyle: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textLight,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(12.w),
            child: Icon(
              Icons.search_outlined,
              color: AppColors.textLight,
              size: 22.w,
            ),
          ),
          suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
              ? GestureDetector(
                  onTap: () {
                    _searchController.clear();
                    controller.searchProducts('');
                    _focusNode.unfocus();
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.w),
                    child: Icon(
                      Icons.clear,
                      color: AppColors.textLight,
                      size: 20.w,
                    ),
                  ),
                )
              : const SizedBox.shrink()),
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: AppColors.borderLight,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: AppColors.borderLight,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: AppColors.primary.withOpacity(0.6),
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 16.h,
          ),
        ),
      ),
    );
  }
}