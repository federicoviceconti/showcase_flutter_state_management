import 'package:showcase_flutter_state_management/riverpod/environment/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import 'shopping_service_mock.dart';

void main() {
  test('Product favorite is set to true', () async {
    final container = ProviderContainer(overrides: [
      shoppingServiceProvider.overrideWithValue(ShoppingServiceMock())
    ]);
    addTearDown(container.dispose);

    final notifier = container.read(homeProvider.notifier);
    await notifier.loadProducts();

    expect(container.read(homeProvider).products, isNotEmpty);

    notifier.onTapFavorite(container.read(homeProvider).products!.first);

    expect(container.read(homeProvider).products!.first.favorite, isTrue);
  });

  test('Products should not be empty', () async {
    final container = ProviderContainer(overrides: [
      shoppingServiceProvider.overrideWithValue(ShoppingServiceMock())
    ]);
    addTearDown(container.dispose);

    final notifier = container.read(homeProvider.notifier);
    await notifier.loadProducts();

    final state = container.read(homeProvider);
    expect(state.products, isNotEmpty);
  });
}
