import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/app/service/shopping_service.dart';

import '../app/product_item.dart';

class InheritedHome extends InheritedWidget {
  final InheritedHomeWrapperState data;

  final Model model;

  const InheritedHome({
    Key? key,
    required super.child,
    this.model = const Model(products: []), required this.data,
  }) : super(key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    final homeWidget = oldWidget as InheritedHome;
    return homeWidget.model != model;
  }
}

class InheritedHomeWrapper extends StatefulWidget {
  final Widget child;

  const InheritedHomeWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  static InheritedHomeWrapperState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedHome>()!.data;
  }

  @override
  State<InheritedHomeWrapper> createState() => InheritedHomeWrapperState();
}

class InheritedHomeWrapperState extends State<InheritedHomeWrapper> {
  Model _model;

  Model get model => _model;

  HomeDataManager _dataManager = HomeDataManager(ShoppingServiceImpl());

  InheritedHomeWrapperState() : _model = const Model(products: null);

  @visibleForTesting
  void overrideDataManager(HomeDataManager dataManager) {
    _dataManager = dataManager;
  }

  @override
  Widget build(BuildContext context) {
    return InheritedHome(
      model: _model,
      data: this,
      child: widget.child,
    );
  }

  void onTapFavorite(ProductItem it) {
    final products = _dataManager.toggleFavorite(
      products: _model.products,
      it: it,
    );

    setState(() {
      _model = Model(products: products);
    });
  }

  Future<void> retrieveProducts() async {
    final items = await _dataManager.getProducts();

    setState(() {
      _model = Model(products: items);
    });
  }
}

class Model extends Equatable {
  final List<ProductItem>? products;

  const Model({this.products});

  @override
  List<Object?> get props => [products];
}
