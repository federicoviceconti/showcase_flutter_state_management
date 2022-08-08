import '../../app/product_item.dart';
import '../../app/service/shopping_service.dart';

class HomeRepository {
  final ShoppingService _service;

  HomeRepository(ShoppingService service) : _service = service;

  Future<List<ProductItem>> getProducts() async {
    final response = await _service.getProducts();
    return ProductItem.fromList(response);
  }
}
