import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexa/features/cart/presentation/controller/cart_controller.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';

class ProductDetailController extends GetxController {
  late ProductModel product;
  final RxInt quantity = 1.obs;
  final RxBool isFavorite = false.obs;
  final CartController cartController = Get.find<CartController>();

  @override
  void onInit() {
    super.onInit();
    product = Get.arguments as ProductModel;
  }

  void incrementQuantity() {
    quantity.value++;
  }

  void decrementQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
  }

  void addToCart() {
    cartController.addToCart(product, quantity.value);
    Get.snackbar(
      'Success',
      '${product.title} added to cart',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.theme.primaryColor,
      colorText: Colors.white,
      duration: Duration(seconds: 2),
    );
  }

  bool get isInCart => cartController.isInCart(product.id);
}
