import 'package:get/get.dart';
import 'package:nexa/features/product_list/data/model/product_list_model.dart';
import 'package:nexa/features/product_list/data/repo/product_list_repo.dart';


class ProductListController extends GetxController {
  final ProductRepository _repository = ProductRepository();
  
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final RxList<ProductModel> filteredProducts = <ProductModel>[].obs;
  final RxList<int> favoriteProducts = <int>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final fetchedProducts = await _repository.getProducts();
      products.value = fetchedProducts;
      filteredProducts.value = fetchedProducts;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((product) =>
              product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void toggleFavorite(int productId) {
    if (favoriteProducts.contains(productId)) {
      favoriteProducts.remove(productId);
    } else {
      favoriteProducts.add(productId);
    }
  }

  bool isFavorite(int productId) {
    return favoriteProducts.contains(productId);
  }

  void retryFetch() {
    fetchProducts();
  }
}
