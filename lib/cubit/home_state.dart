import 'package:equatable/equatable.dart';

import '../app/product_item.dart';

class HomeState extends Equatable {
  final List<ProductItem>? products;

  const HomeState({
    this.products,
  });

  HomeState copyWith({List<ProductItem>? products}) {
    return HomeState(
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
        products,
      ];
}
