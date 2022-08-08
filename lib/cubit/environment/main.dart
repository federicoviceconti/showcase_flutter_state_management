import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app/service/shopping_service.dart';
import '../../app/datamanager/home_datamanager.dart';
import '../home_view.dart';
import '../home_cubit.dart';
import '../home_state.dart';

void main() {
  runApp(const ShoppingApp());
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: kIsWeb || (!Platform.isIOS || !Platform.isAndroid)
          ? MouseTouchScrollBehaviour()
          : null,
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<ShoppingService>(
            create: (_) => ShoppingServiceImpl(),
          ),
          RepositoryProvider<HomeDataManager>(
            create: (_) => HomeDataManager(
              RepositoryProvider.of<ShoppingService>(_),
            ),
          ),
        ],
        child: BlocProvider(
          create: (_) => HomeCubit(
            const HomeState(),
            RepositoryProvider.of<HomeDataManager>(_),
          ),
          child: const HomeView(),
        ),
      ),
    );
  }
}

class MouseTouchScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
