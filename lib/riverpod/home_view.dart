import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcase_flutter_state_management/riverpod/environment/main.dart';

import '../app/shopping_list_items.dart';
import '../app/subtitle_widget.dart';
import '../app/title_widget.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((timeStamp) {
        ref.read(homeProvider.notifier).loadProducts();
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                TitleWidget(),
                SizedBox(height: 8.0),
                SubtitleWidget(),
                SizedBox(height: 16.0),
                ConsumerListWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConsumerListWidget extends ConsumerWidget {
  const ConsumerListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeProvider);

    if (notifier.products == null) {
      return const CircularProgressIndicator();
    } else {
      return ShoppingListItems(
        products: notifier.products!,
        onTapFavorite: ref.read(homeProvider.notifier).onTapFavorite,
      );
    }
  }
}
