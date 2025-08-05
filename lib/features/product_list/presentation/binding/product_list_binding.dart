import 'package:get/get.dart';
import 'package:nexa/features/product_list/presentation/controller/product_list_controller.dart';

class ProductListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductListController>(() => ProductListController());
  }
}
