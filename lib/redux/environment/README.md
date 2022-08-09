# Redux

You can read more about usage on the official site: https://redux.js.org/usage/.

Here the dart version: https://github.com/fluttercommunity/redux.dart.

This pattern was inspired from [Flux](https://facebook.github.io/flux/).

Here you can find a complete example of redux
usage: https://github.com/brianegan/flutter_architecture_samples

## Reasons to use

- *Master the state*: the aim of the library is to always have control of state changes, making it:
    - read-only,
    - performing changes through pure functions,
    - having a single source of truth.
- *Middleware for asynchronous*: is another layer, used for performing asynchronous requests. It's
  between actions dispatch and reducer functions.

## Getting started

### Handling store

- `Store`: holds the app state, it's read only
- `StoreProvider`: root widget, provides a store to all descendant widget
    - takes a `Store` parameter
- `StoreConnector`: works like a consumer, finds the nearest `StoreProvider` on the ancestor tree
    - provides a `converter` for use a ready-to-use model for the `builder` parameter
    - `builder` is used to consume the model
- `StoreBuilder`: works like the connector, but has only a builder with the store

### Dispatching an action

Previously, we said that the state is immutable. The only way to change it is to run pure functions,
called reducers. In order to work, we need
to [dispatch](https://pub.dev/documentation/redux/latest/redux/Store/dispatch.html) an action.

### Handling state change

When we use the `dispatch`, the action will be applied to middleware and reducers.

#### Reducer

`Reducer<State>` defines the state change. Takes the previous state and an action parameter.

*TypedReducer*

[TypedReducer<State, Action>](https://pub.dev/documentation/redux/latest/redux/TypedReducer-class.html)
wire up specific types of actions to our reducer functions.

```
final loadItemsReducer = (AppState state, LoadTodosAction action) => AppState(action.items);

final updateItemsReducer = (AppState state, UpdateItemsAction action) {
  return ...;
}

final addItemReducer = (AppState state, AddItemAction action) {
  return ...;
}

final Reducer<AppState> appReducer = combineReducers([
  new TypedReducer<AppState, LoadTodosAction>(loadItemsReducer),
  new TypedReducer<AppState, UpdateItemsAction>(updateItemsReducer),
  new TypedReducer<AppState, AddItemAction>(addItemReducer),
]);
```

*Handling more reducers*

On our app it's possible to have one or more reducers. As the documentation said:

**In order to prevent having one large, monolithic reducer in your app, it can be convenient to ->
break reducers up into smaller parts <- that handle more specific functionality that can be
decoupled and easily tested.**

`combineReducers<State>` [function](https://pub.dev/documentation/redux/latest/redux/combineReducers.html)

```dart

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, TodosLoadedAction>(_setLoaded),
  TypedReducer<bool, TodosNotLoadedAction>(_setNotLoaded),
]);

bool _setLoaded(bool state, action) {
  return true;
}

bool _setNotLoaded(bool state, action) {
  return false;
}
```

#### Middleware

It's used to intercepts action and transform them before they reach the reducer. An usage is for
performing API requests.

They must be specified on the `Store<State>` Widget:

```dart

final store = Store<AppState>(
  searchReducer,
  initialState: AppStateInitial(),
  middleware: [
    AsyncMiddlewareExample(ApiExample()),
  ],
);
```

Also, they can be used with `TypedMiddleware<State, Action>` class. It allows to make it type safe
and reduces boilerplate:

```dart

saveItemsMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  next(action);
  _saveItems(store.state.items);
}

final List<Middleware<AppState>> middleware = [
  TypedMiddleware<AppState, AddTodoAction>(saveItemsMiddleware),
];
```