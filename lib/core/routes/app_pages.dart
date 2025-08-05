import 'package:get/get.dart';
import 'package:nexa/features/cart/presentation/binding/cart_binding.dart';
import 'package:nexa/features/cart/presentation/screen/cart_screen.dart';
import 'package:nexa/features/product_details/presentation/binding/product_detail_binding.dart';
import 'package:nexa/features/product_details/presentation/screen/product_detail_screen.dart';
import 'package:nexa/features/product_list/presentation/binding/product_list_binding.dart';
import 'package:nexa/features/product_list/presentation/screen/product_list_screen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.productList;

  static final routes = [
    GetPage(
      name: AppRoutes.productList,
      page: () => const ProductListScreen(),
      bindings: [
        ProductListBinding(),
        CartBinding(),
      ],
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailScreen(),
      binding: ProductDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
  ];
}
