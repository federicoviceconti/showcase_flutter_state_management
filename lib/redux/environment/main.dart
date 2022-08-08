import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import '../../app/service/shopping_service.dart';
import '../../redux/repository/home_repository.dart';
import '../home_view.dart';
import '../reducer.dart';
import '../shopping_middleware.dart';
import '../state.dart';

void main() {
  final store = Store<AppState>(
    reducers,
    initialState: NoResultState(),
    middleware: [
      ShoppingMiddleware(
        HomeRepository(
          ShoppingServiceImpl(),
        ),
      ),
    ],
  );

  runApp(ShoppingApp(store));
}

class ShoppingApp extends StatelessWidget {
  final Store<AppState> store;

  const ShoppingApp(
    this.store, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: kIsWeb || (!Platform.isIOS || !Platform.isAndroid)
          ? MouseTouchScrollBehaviour()
          : null,
      home: StoreProvider<AppState>(
        store: store,
        child: const HomeView(),
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
