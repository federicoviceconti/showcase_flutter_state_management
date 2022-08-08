import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';

import '../app/product_item.dart';
import 'package:mobx/mobx.dart';

part 'shopping_store.g.dart';

class ShoppingStore extends _ShoppingStore with _$ShoppingStore {
  ShoppingStore(super.dataManager);
}

abstract class _ShoppingStore with Store {
  final HomeDataManager _dataManager;

  _ShoppingStore(HomeDataManager dataManager) : _dataManager = dataManager;

  @computed
  bool get hasResults =>
      products.status == FutureStatus.fulfilled && products.value != null;

  @observable
  ObservableFuture<List<ProductItem>?> products = ObservableFuture.value(null);

  @action
  Future<List<ProductItem>> loadProducts() async {
    final response = _dataManager.getProducts();
    products = ObservableFuture(response);
    return response;
  }

  @action
  Future<List<ProductItem>?> onTapFavorite(ProductItem it) {
    final response = Future.value(_dataManager.toggleFavorite(
      products: products.value,
      it: it,
    ));

    products = ObservableFuture(response);

    return response;
  }
}
