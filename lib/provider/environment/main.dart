import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app/datamanager/home_datamanager.dart';
import '../../app/service/shopping_service.dart';
import '../home_view.dart';
import '../home_view_model.dart';

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
      home: MultiProvider(
        providers: [
          Provider<ShoppingService>(
            create: (_) => ShoppingServiceImpl(),
          ),
          ProxyProvider<ShoppingService, HomeDataManager>(
            update: (_, service, __) => HomeDataManager(service),
          ),
          ChangeNotifierProxyProvider<HomeDataManager, HomeViewModel>(
            create: (context) => HomeViewModel(context.read<HomeDataManager>()),
            update: (_, dm, __) => HomeViewModel(dm),
          ),
        ],
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
