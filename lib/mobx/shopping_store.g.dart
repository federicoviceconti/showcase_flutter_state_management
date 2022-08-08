// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ShoppingStore on _ShoppingStore, Store {
  late final _$productsAtom =
      Atom(name: '_ShoppingStore.products', context: context);

  @override
  ObservableFuture<List<ProductItem>?> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableFuture<List<ProductItem>?> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$loadProductsAsyncAction =
      AsyncAction('_ShoppingStore.loadProducts', context: context);

  @override
  Future<List<ProductItem>> loadProducts() {
    return _$loadProductsAsyncAction.run(() => super.loadProducts());
  }

  @override
  String toString() {
    return '''
products: ${products}
    ''';
  }
}
