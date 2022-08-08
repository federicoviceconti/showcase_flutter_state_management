import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcase_flutter_state_management/riverpod/environment/main.dart';
import '../app/datamanager/home_datamanager.dart';
import '../app/product_item.dart';
import 'home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeDataManager _dataManager;

  factory HomeNotifier.fromProvider(Reader read) {
    return HomeNotifier(read(dataManagerProvider));
  }

  HomeNotifier(HomeDataManager dataManager)
      : _dataManager = dataManager,
        super(const HomeState(products: null));

  Future<void> loadProducts() async {
    final products = await _dataManager.getProducts();
    state = state.copyWith(products: products);
  }

  void onTapFavorite(ProductItem it) {
    final products = _dataManager.toggleFavorite(
      products: state.products,
      it: it,
    );

    state = state.copyWith(products: products);
  }
}
