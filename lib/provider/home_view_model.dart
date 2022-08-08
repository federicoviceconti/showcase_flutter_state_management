import 'package:flutter/material.dart';
import '../app/datamanager/home_datamanager.dart';
import '../app/product_item.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeDataManager _dataManager;

  List<ProductItem>? _products;

  List<ProductItem>? get products => _products;

  HomeViewModel(HomeDataManager dataManager) : _dataManager = dataManager;

  Future<void> loadProducts() async {
    final products = await _dataManager.getProducts();
    _products = products;
    notifyListeners();
  }

  void onTapFavorite(ProductItem it) {
    _products = _dataManager.toggleFavorite(
      products: _products,
      it: it,
    );
    notifyListeners();
  }
}
