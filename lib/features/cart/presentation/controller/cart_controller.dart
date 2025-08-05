import 'package:get/get.dart';
import 'package:nexa/features/cart/data/model/cart_item_model.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  int get itemCount => cartItems.fold(0, (sum, item) => sum + item.quantity);
  
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  void addToCart(ProductModel product, int quantity) {
    final existingIndex = cartItems.indexWhere((item) => item.product.id == product.id);
    
    if (existingIndex != -1) {
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + quantity,
      );
    } else {
      cartItems.add(CartItemModel(product: product, quantity: quantity));
    }
  }

  void removeFromCart(int productId) {
    cartItems.removeWhere((item) => item.product.id == productId);
  }

  void updateQuantity(int productId, int newQuantity) {
    if (newQuantity <= 0) {
      removeFromCart(productId);
      return;
    }
    
    final index = cartItems.indexWhere((item) => item.product.id == productId);
    if (index != -1) {
      cartItems[index] = cartItems[index].copyWith(quantity: newQuantity);
    }
  }

  void clearCart() {
    cartItems.clear();
  }

  bool isInCart(int productId) {
    return cartItems.any((item) => item.product.id == productId);
  }

  CartItemModel? getCartItem(int productId) {
    try {
      return cartItems.firstWhere((item) => item.product.id == productId);
    } catch (e) {
      return null;
    }
  }
}
