import 'package:flutter/material.dart';

import 'repository/home_repository.dart';
import 'actions.dart';
import 'state.dart';
import 'package:redux/redux.dart';

class ShoppingMiddleware implements MiddlewareClass<AppState> {
  final HomeRepository _repository;

  ShoppingMiddleware(HomeRepository repository) : _repository = repository;

  @override
  void call(Store<AppState> store, action, NextDispatcher next) {
    if (action is FetchAction) {
      debugPrint('Start loading...');

      _repository.getProducts().then((products) {
        store.dispatch(ResultAction(products));
      });
    }

    next(action);
  }
}
