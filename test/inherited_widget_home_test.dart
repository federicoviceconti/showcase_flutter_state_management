import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/inherited_widget/inherited_home.dart';

import 'shopping_service_mock.dart';

void main() {
  InheritedHome? inheritedHome;

  setUp(() {
    final state = _InheritedHomeMockWrapperState();
    state.overrideDataManager(HomeDataManager(ShoppingServiceMock()));

    inheritedHome = InheritedHome(
      data: state,
      child: MaterialApp(
        home: Container(),
      ),
    );
  });

  tearDown(() {
    inheritedHome = null;
  });

  testWidgets('Products should not be empty', (WidgetTester tester) async {
    await tester.pumpWidget(inheritedHome!);
    await tester.pumpAndSettle();

    await inheritedHome!.data.retrieveProducts();
    expect(inheritedHome!.data.model.products, isNotEmpty);
  });

  testWidgets('Product favorite is set to true', (WidgetTester tester) async {
    await tester.pumpWidget(inheritedHome!);
    await tester.pumpAndSettle();

    await inheritedHome!.data.retrieveProducts();
    inheritedHome!.data.onTapFavorite(inheritedHome!.data.model.products!.first);

    expect(inheritedHome!.data.model.products!.first.favorite, isTrue);
  });
}

class _InheritedHomeMockWrapperState extends InheritedHomeWrapperState {
  @override
  void setState(VoidCallback fn) {
    fn();
  }
}
