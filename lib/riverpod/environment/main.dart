import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcase_flutter_state_management/app/datamanager/home_datamanager.dart';
import 'package:showcase_flutter_state_management/app/service/shopping_service.dart';
import 'package:showcase_flutter_state_management/riverpod/home_notifier.dart';

import '../home_state.dart';
import '../home_view.dart';

final shoppingServiceProvider = Provider<ShoppingService>((ref) => ShoppingServiceImpl());
final dataManagerProvider = Provider(
  (ref) => HomeDataManager.fromProvider(ref.read),
);
final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(
  (ref) => HomeNotifier.fromProvider(ref.read),
);

void main() {
  runApp(const ProviderScope(
    child: ShoppingApp(),
  ));
}

class ShoppingApp extends StatelessWidget {
  const ShoppingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: kIsWeb || (!Platform.isIOS || !Platform.isAndroid)
          ? MouseTouchScrollBehaviour()
          : null,
      home: const HomeView(),
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
