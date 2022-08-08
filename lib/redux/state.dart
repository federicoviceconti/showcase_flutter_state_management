import 'package:flutter/material.dart';

import '../app/product_item.dart';

@immutable
abstract class AppState {}

@immutable
class NoResultState extends AppState {}

@immutable
class ResultState extends AppState {
  final List<ProductItem>? products;

  ResultState({
    this.products,
  });
}
