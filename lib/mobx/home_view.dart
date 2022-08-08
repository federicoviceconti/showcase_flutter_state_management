import 'package:flutter/material.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/app/service/shopping_service.dart';
import 'package:showcase_flutter_state_management/mobx/shopping_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../app/shopping_list_items.dart';
import '../app/subtitle_widget.dart';
import '../app/title_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final ShoppingStore store = ShoppingStore(
    HomeDataManager(
      ShoppingServiceImpl(),
    ),
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((timeStamp) {
        store.loadProducts();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWidget(),
              const SizedBox(height: 8.0),
              const SubtitleWidget(),
              const SizedBox(height: 16.0),
              ConsumeShoppingList(store: store),
            ],
          ),
        ),
      ),
    );
  }
}

class ConsumeShoppingList extends StatelessWidget {
  final ShoppingStore store;

  const ConsumeShoppingList({
    required this.store,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (store.hasResults) {
        return ShoppingListItems(
          products: store.products.value ?? [],
          onTapFavorite: (it) => store.onTapFavorite(it),
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
