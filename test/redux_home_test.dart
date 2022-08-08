import 'package:flutter_test/flutter_test.dart';
import 'package:redux/redux.dart';
import 'package:showcase_flutter_state_management/redux/actions.dart';
import 'package:showcase_flutter_state_management/redux/reducer.dart';
import 'package:showcase_flutter_state_management/redux/repository/home_repository.dart';
import 'package:showcase_flutter_state_management/redux/shopping_middleware.dart';
import 'package:showcase_flutter_state_management/redux/state.dart';

import 'shopping_service_mock.dart';

void main() {
  Store<AppState>? store;

  setUp(() {
    store = Store<AppState>(
      reducers,
      initialState: NoResultState(),
      middleware: [
        ShoppingMiddleware(
          HomeRepository(
            ShoppingServiceMock(),
          ),
        ),
      ],
    );
  });

  tearDown(() {

  });

  test('Products should not be empty', () async {
    await store?.dispatch(FetchAction());
    expect((store!.state as ResultState).products, isNotEmpty);
  });

  test('Product favorite is set to true', () async {
    await store?.dispatch(FetchAction());
    final products = (store!.state as ResultState).products;
    await store?.dispatch(ToggleAction(products!.first));
    expect((store!.state as ResultState).products!.first.favorite, isTrue);
  });
}
