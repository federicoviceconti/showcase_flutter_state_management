import 'package:showcase_flutter_state_management/app/service/products_response.dart';

class ProductItem {
  final String name;
  final String description;
  final String category;
  final String imgUrl;
  final double price;
  final bool favorite;

  ProductItem({
    this.name = '',
    this.imgUrl = '',
    this.price = 0.0,
    this.category = '',
    this.description = '',
    this.favorite = false,
  });

  ProductItem toggleFavorite(bool value) {
    return ProductItem(
      favorite: value,
      imgUrl: imgUrl,
      price: price,
      category: category,
      name: name,
      description: description,
    );
  }

  static List<ProductItem> fromList(List<Product> list) {
    return list.map((item) {
      return ProductItem(
        name: item.title ?? '',
        category: item.category ?? '',
        price: item.price ?? 0.0,
        imgUrl: item.image ?? '',
        description: item.description ?? '',
        favorite: false,
      );
    }).toList();
  }
}
