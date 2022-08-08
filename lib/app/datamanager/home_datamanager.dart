import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../riverpod/environment/main.dart';
import '../product_item.dart';
import '../service/shopping_service.dart';

class HomeDataManager {
  final ShoppingService _service;

  HomeDataManager.fromProvider(Reader read)
      : _service = read(shoppingServiceProvider);

  HomeDataManager(ShoppingService service) : _service = service;

  Future<List<ProductItem>> getProducts() async {
    final response = await _service.getProducts();
    return ProductItem.fromList(response);
  }

  List<ProductItem>? toggleFavorite({
    required List<ProductItem>? products,
    required ProductItem it,
  }) {
    return products?.map((item) {
      if (item == it) {
        return item.toggleFavorite(!item.favorite);
      }

      return item;
    }).toList();
  }
}
