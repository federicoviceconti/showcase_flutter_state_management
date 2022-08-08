import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../app/product_item.dart';
import '../app/shopping_list_items.dart';
import '../app/subtitle_widget.dart';
import '../app/title_widget.dart';
import 'actions.dart';
import 'state.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _HomeViewModel>(
      converter: (store) {
        return _HomeViewModel(
            state: store.state,
            onTapFavorite: (item) {
              store.dispatch(ToggleAction(item));
            });
      },
      onInit: (store) {
        debugPrint('dispatch fetch');
        store.dispatch(FetchAction());
      },
      builder: (_, vm) {
        debugPrint(vm.state.runtimeType.toString());
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
                  ConsumeShoppingListStore(vm.state, (item) {
                    vm.onTapFavorite(item);
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HomeViewModel {
  final AppState state;

  final Function(ProductItem) onTapFavorite;

  _HomeViewModel({
    required this.state,
    required this.onTapFavorite,
  });
}

class ConsumeShoppingListStore extends StatelessWidget {
  final AppState state;

  final Function(ProductItem) onTapFavorite;

  const ConsumeShoppingListStore(
    this.state,
    this.onTapFavorite, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is ResultState) {
      return ShoppingListItems(
        products: (state as ResultState).products!,
        onTapFavorite: onTapFavorite,
      );
    }

    return const CircularProgressIndicator();
  }
}
