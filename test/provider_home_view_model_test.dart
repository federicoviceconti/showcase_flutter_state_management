import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/provider/home_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import 'shopping_service_mock.dart';

void main() {
  late HomeViewModel viewModel;

  setUp(() {
    viewModel = HomeViewModel(HomeDataManager(ShoppingServiceMock()));
  });

  tearDown(() {
    viewModel.dispose();
  });

  test('Products should not be empty', () async {
    await viewModel.loadProducts();
    expect(viewModel.products, isNotEmpty);
  });

  test('Product favorite is set to true', () async {
    await viewModel.loadProducts();
    viewModel.onTapFavorite(viewModel.products!.first);

    expect(viewModel.products!.first.favorite, isTrue);
  });
}
