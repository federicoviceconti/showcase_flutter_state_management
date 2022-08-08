import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/shopping_list_items.dart';
import '../app/subtitle_widget.dart';
import '../app/title_widget.dart';
import 'home_view_model.dart';

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
      ..addPostFrameCallback((timeStamp) {
        Provider.of<HomeViewModel>(context, listen: false).loadProducts();
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
              Consumer<HomeViewModel>(
                builder: (_, viewModel, __) {
                  if (viewModel.products == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return ShoppingListItems(
                      products: viewModel.products!,
                      onTapFavorite: (it) =>
                          _.read<HomeViewModel>().onTapFavorite(it),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
