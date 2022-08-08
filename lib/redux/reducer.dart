import 'package:showcase_flutter_state_management/app/product_item.dart';
import 'package:showcase_flutter_state_management/redux/actions.dart';
import 'package:redux/redux.dart';

import 'state.dart';

final reducers = combineReducers<AppState>([
  TypedReducer<AppState, ToggleAction>((state, action) {
    List<ProductItem>? products;

    if (state is ResultState) {
      products = state.products?.map((item) {
        if (item == action.product) {
          return item.toggleFavorite(!item.favorite);
        }

        return item;
      }).toList();
    }

    return ResultState(
      products: products,
    );
  }),
  TypedReducer<AppState, ResultAction>((state, action) {
    return ResultState(
      products: action.products,
    );
  }),
  TypedReducer<AppState, ToggleAction>((state, action) {
    if (state is ResultState) {
      return ResultState(
        products: state.products,
      );
    }

    return state;
  }),
]);
