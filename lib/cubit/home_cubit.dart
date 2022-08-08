import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_flutter_state_management/app/product_item.dart';
import '../app/datamanager/home_datamanager.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeDataManager _dataManager;

  HomeCubit(super.initialState, HomeDataManager dataManager)
      : _dataManager = dataManager;

  Future<void> loadProducts() async {
    final products = await _dataManager.getProducts();
    emit(state.copyWith(products: products));
  }

  void onTapFavorite(ProductItem it) {
    emit(
      state.copyWith(
        products: _dataManager.toggleFavorite(
          products: state.products,
          it: it,
        ),
      ),
    );
  }
}
