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
      if (searchQuery.value.isEmpty) {
        filteredProducts.value = fetchedProducts;
      } else {
        _filterProducts(searchQuery.value);
      }
    } catch (e) {
      errorMessage.value = e.toString();
      products.clear();
      filteredProducts.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    _filterProducts(query);
  }

  void _filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts.value = List.from(products);
    } else {
      final lowerQuery = query.toLowerCase().trim();
      filteredProducts.value = products.where((product) {
        final titleMatch = product.title.toLowerCase().contains(lowerQuery);
        final categoryMatch = product.category.toLowerCase().contains(lowerQuery);
        final descriptionMatch = product.description.toLowerCase().contains(lowerQuery);
        
        return titleMatch || categoryMatch || descriptionMatch;
      }).toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredProducts.value = List.from(products);
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

  void filterByCategory(String category) {
    if (category.isEmpty || category.toLowerCase() == 'all') {
      filteredProducts.value = List.from(products);
    } else {
      filteredProducts.value = products
          .where((product) => 
              product.category.toLowerCase() == category.toLowerCase())
          .toList();
    }
    searchQuery.value = '';
  }

  List<String> get categories {
    final Set<String> categorySet = {};
    for (var product in products) {
      categorySet.add(product.category);
    }
    return ['All', ...categorySet.toList()];
  }

  void sortProducts(String sortBy) {
    List<ProductModel> sortedList = List.from(filteredProducts);
    
    switch (sortBy.toLowerCase()) {
      case 'price_low':
        sortedList.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sortedList.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'rating':
        sortedList.sort((a, b) => b.rating.rate.compareTo(a.rating.rate));
        break;
      case 'name':
        sortedList.sort((a, b) => a.title.compareTo(b.title));
        break;
      default:
        sortedList.sort((a, b) => a.id.compareTo(b.id));
    }
    
    filteredProducts.value = sortedList;
  }

  @override
  void onClose() {
    super.onClose();
  }
}