import 'package:flutter_test/flutter_test.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/mobx/shopping_store.dart';

import 'shopping_service_mock.dart';

void main() {
  ShoppingStore? shoppingStore;

  setUp(() {
    shoppingStore = ShoppingStore(HomeDataManager(ShoppingServiceMock()));
  });

  tearDown(() {
    shoppingStore = null;
  });

  test('Products should not be empty', () async {
    await shoppingStore!.loadProducts();
    expect(shoppingStore!.products.value, isNotEmpty);
  });

  test('hasResult', () async {
    await shoppingStore!.loadProducts();
    expect(shoppingStore!.hasResults, isTrue);
  });

  test('Product favorite is set to true', () async {
    await shoppingStore!.loadProducts();
    await shoppingStore!.onTapFavorite(shoppingStore!.products.value!.first);

    expect(shoppingStore!.products.value!.first.favorite, isTrue);
  });
}
