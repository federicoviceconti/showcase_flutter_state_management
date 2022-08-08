import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showcase_flutter_state_management/cubit/home_state.dart';

import 'home_cubit.dart';
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
      ..addPostFrameCallback((timeStamp) {
        context.read<HomeCubit>().loadProducts();
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
              BlocConsumer<HomeCubit, HomeState>(
                builder: (_, state) {
                  if (state.products == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return ShoppingListItems(
                      products: state.products!,
                      onTapFavorite: (it) =>
                          _.read<HomeCubit>().onTapFavorite(it),
                    );
                  }
                },
                listener: (_, __) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
