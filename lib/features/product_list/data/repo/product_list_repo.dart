import 'package:nexa/features/product_list/data/model/product_list_model.dart';
import '../../../../core/network/api_service.dart';

class ProductRepository {
  Future<List<ProductModel>> getProducts() async {
    try {
      final data = await ApiService.getProducts();
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<ProductModel> getProduct(int id) async {
    try {
      final data = await ApiService.getProduct(id);
      return ProductModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }
}
