import 'package:flutter/material.dart';
import 'package:showcase_flutter_state_management/inherited_widget/inherited_home.dart';
import '../app/shopping_list_items.dart';
import '../app/subtitle_widget.dart';
import '../app/title_widget.dart';

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
      ..addPostFrameCallback((timeStamp) async {
        await InheritedHomeWrapper.of(context).retrieveProducts();
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
            children: const [
              TitleWidget(),
              SizedBox(height: 8.0),
              SubtitleWidget(),
              SizedBox(height: 16.0),
              ShoppingListWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class ShoppingListWidget extends StatelessWidget {
  const ShoppingListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = InheritedHomeWrapper.of(context).model.products;

    if (products == null) {
      return const CircularProgressIndicator();
    } else {
      return ShoppingListItems(
        products: products,
        onTapFavorite: (it) =>
            InheritedHomeWrapper.of(context).onTapFavorite(it),
      );
    }
  }
}
