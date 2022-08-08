import 'package:flutter_test/flutter_test.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/cubit/home_cubit.dart';
import 'package:showcase_flutter_state_management/cubit/home_state.dart';

import 'shopping_service_mock.dart';

void main() {
  late HomeCubit homeCubit;

  setUp(() {
    homeCubit = HomeCubit(
      const HomeState(),
      HomeDataManager(ShoppingServiceMock()),
    );
  });

  tearDown(() {
    homeCubit.close();
  });

  test('Products should not be empty', () async {
    await homeCubit.loadProducts();
    expect(homeCubit.state.products, isNotEmpty);
  });

  test('Product favorite is set to true', () async {
    await homeCubit.loadProducts();
    homeCubit.onTapFavorite(homeCubit.state.products!.first);

    expect(homeCubit.state.products!.first.favorite, isTrue);
  });
}
