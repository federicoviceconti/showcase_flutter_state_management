import '../app/product_item.dart';

class AppAction {}

class FetchAction extends AppAction {}

class ResultAction extends AppAction {
  final List<ProductItem>? products;

  ResultAction(this.products);
}

class ToggleAction extends AppAction {
  final ProductItem product;

  ToggleAction(this.product);
}
