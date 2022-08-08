import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/inherited_widget/inherited_home.dart';

import 'shopping_service_mock.dart';

void main() {
  _InheritedHomeMockWrapperState? state;

  setUp(() {
    state = _InheritedHomeMockWrapperState();
    state!.overrideDataManager(HomeDataManager(ShoppingServiceMock()));
  });

  tearDown(() {
    state = null;
  });

  test('Products should not be empty', () async {
    await state!.retrieveProducts();
    expect(state!.model.products, isNotEmpty);
  });

  test('Product favorite is set to true', () async {
    await state!.retrieveProducts();
    state!.onTapFavorite(state!.model.products!.first);

    expect(state!.model.products!.first.favorite, isTrue);
  });
}

class _InheritedHomeMockWrapperState extends InheritedHomeWrapperState {
  @override
  void setState(VoidCallback fn) {
    fn();
  }
}
