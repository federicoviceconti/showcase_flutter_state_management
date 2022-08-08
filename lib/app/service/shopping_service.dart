import 'package:http/http.dart';

import 'products_response.dart';

abstract class ShoppingService {
  Future<List<Product>> getProducts();

  Future<Product> getProduct(int id);
}

class ShoppingServiceImpl extends ShoppingService {
  @override
  Future<List<Product>> getProducts() async {
    final response = await get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    return Product.fromResponseToList(response);
  }

  @override
  Future<Product> getProduct(int id) async {
    final response = await get(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );
    return Product.fromResponseToObject(response);
  }
}
