# flutter_bloc

As documentation said:

```
Widgets that make it easy to integrate blocs and cubits into Flutter. Built to work with package:
bloc.
```

## Reasons to use

- *Extremely easy*:
    - allows to combine all the functionality of provider, using blocs.
    - no extra effort for testing widgets

## Getting started

Into this folder you can find an example of Cubit. It manages all the business logic. Also, it's
needed to specify the state object, passing on the constructor the initial state.

```dart
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(super.initialState);

  /// Custom business logics...
  updateState(dynamic value) {

    /// Update state using emit function, with custom data
    emit(state.copyWith(value));
  }
}
```

In order to use it on the UI, first we need to wrap the main widget with BlocProvider, that takes
the cubit and the UI to render.

```dart
class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => HomeCubit(HomeState.initial()),
        child: HomePage(),
      ),
    );
  }
}
```

Then, we can use the `watch` method or custom widgets (like `BlocBuilder`, `BlocConsumer`) to
retrieve the current state. To retrieve the cubit without adding a listener, we can just use
the `read` method.

```dart
@override
Widget build(BuildContext context) {
  return BlocConsumer<HomeCubit, HomeState>(
    builder: (BuildContext context, HomeState state) {
      if (state.products == null) {
        return const CircularProgressIndicator();
      } else {
        return ShoppingListItems(
          products: state.products!,
          onTapFavorite: (it) => context.read<HomeCubit>().onTapFavorite(it),
        );
      }
    },
    listener: (_, __) {},
  );
}
```