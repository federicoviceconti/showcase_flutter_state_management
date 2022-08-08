# Riverpod

More here https://riverpod.dev/docs.

## Reasons to use

- *Care about performance*: only what is impacted by provider is rebuilt
- *Test friendly*:
    - Widget testing does not require extra efforts to allow test
    - It's possible to override dependencies to mock behavior. See *testing+.

## Getting started

In order to work, the root must be wrapped with `ProviderScope`. This class allows to store the
state of providers:

```dart
void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}
```

To use an implementation of Provider, just declare a global variable that handle a Provider object:

```dart

final myProvider = Provider((ref) {
  return MyValue();
});
```

Remember:

- They're fully immutable
- Must be always final, to avoid changes
- It's possible to declare 1/+ provider exposing the same type

```dart

final cityProvider = Provider((ref) => 'London');
final countryProvider = Provider((ref) => 'England');
```

### Provider implementation

Here, you can find
a [list of providers](https://riverpod.dev/docs/concepts/providers#different-types-of-providers)
ready to use.

### Reading providers

*The ref object*

Used to interact with other provider, also contains the state.
See [ProviderRef<State>](https://pub.dev/documentation/riverpod/latest/riverpod/ProviderRef-class.html)
. It's usually used for:

- read method
- listen method: attach a listener to execute, for example, an action
- watch method: obtain a value and attach a listener for changes. **It's better to use it**, to make
  the app reactive.

This section explains which method you should
use: https://riverpod.dev/docs/concepts/reading#using-refread-to-obtain-the-state-of-a-provider.

*Best practice for using read during Provider creation*

Riverpod best practice said to use the following approach:

```dart

final userTokenProvider = StateProvider<String>((ref) => null);
final repositoryProvider = Provider((ref) => Repository(ref.read));

class Repository {
  Repository(this.read);

  /// The `ref.read` function
  final Reader read;
}
```

It's also easy to test
using [ProviderContainer](https://riverpod.dev/docs/concepts/combining_providers/#how-to-test-an-object-that-receives-read-as-a-parameter-of-its-constructor)
.

*Widgets*

Stateless and Stateful widgets are replaced by:

- ConsumerWidget: for stateless, adding a ref variable
- ConsumerStatefulWidget: the ref is a property
