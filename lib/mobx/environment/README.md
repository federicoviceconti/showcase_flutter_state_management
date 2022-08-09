# MobX

Connect reactive data with UI, without renouncing scalability and simplicity.

## Reasons to use

- *It's very easy to use*:
    - it has a [codegen library](https://github.com/mobxjs/mobx.dart/tree/master/mobx_codegen) to
      reduce code boilerplate
    - it's founded on three concepts: observables, actions and reactions
- *Makes app reactive, decoupling state from UI*:
    - data are contained into one or more stores
    - `@observable` data makes the reactive state-tree

## Getting started

The main concepts about MobX are:
- observables: it's the reactive-state part of the app
  - The `Observable` class wrap your data and make it reactive for the UI
  - On the codegen library is used the annotation on the `@observable` variable 
- actions: describe how the state change
  - The `Observable` is a class that define a function for changing state
  - On the codegen library is used the annotation on the `@action` method
- derivations: 
  - computed: manipulate store properties to returns a value when they change
    - On the codegen library is used the annotation on the `@action` property
  - reactions `autorun`, `when`, `reaction`: track an observable and run when the state change

Following an example of usage for a counter app:

```dart
import 'package:mobx/mobx.dart';

part 'counter.g.dart';

class Counter = CounterBase with _$Counter;

/// Where is contained the counter state
abstract class CounterBase with Store {
  
  /// Ui is reloaded when `value` change
  @observable
  int value = 0;

  /// Method used for changing state
  @action
  void increment() {
    value++;
  }
}
```