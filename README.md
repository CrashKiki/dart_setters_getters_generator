<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages). 
-->

# Dart Setters Getters Generator

A Dart code generator that creates ModelVariable wrappers for class fields, providing enhanced getter/setter functionality with change detection.

## Features

- **Automatic code generation** - Annotate classes with `@AutoVariables()` to generate ModelVariable wrappers
- **Change detection** - Only updates values when they actually change
- **Type safety** - Supports all Dart types including generics like `List<T>` and `Map<K,V>`
- **Alternative access methods** - Provides both `.value` property and `.get()`/`.set()` methods
- **Zero runtime dependencies** - Only requires dependencies during build time

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dart_setters_getters_generator: ^1.0.0

dev_dependencies:
  build_runner: ^2.4.0
```

## Usage

1. Annotate your classes with `@AutoVariables()`:

```dart
import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';

@AutoVariables()
class Person {
  String name = '';
  int age = 0;
  List<String> hobbies = [];
}
```

2. Run the code generator:

```bash
dart pub run build_runner build
```

3. Import the generated file and use the variables:

```dart
import 'my_model.setters_getters.g.dart';

void main() {
  final person = Person();
  
  // Access through generated variables
  person.variables.name.value = 'John Doe';
  person.variables.age.value = 30;
  person.variables.hobbies.value = ['reading', 'coding'];
  
  // Alternative access methods
  person.variables.age.set(31);
  print(person.variables.name.get()); // 'John Doe'
  
  // Changes are automatically reflected in the original object
  print(person.name); // 'John Doe'
  print(person.age);  // 31
}
```

## Build Configuration

The package automatically configures build_runner, but you can customize it in `build.yaml`:

```yaml
targets:
  $default:
    builders:
      dart_setters_getters_generator|setters_getters_builder:
        enabled: true
```

## Features Details

### Change Detection
ModelVariable only updates values when they actually change:

```dart
person.variables.age.value = 25; // Updates the value
person.variables.age.value = 25; // No change, no update
```

### Type Support
Works with all Dart types:

```dart
@AutoVariables()
class MyModel {
  String text = '';
  int number = 0;
  bool flag = false;
  List<String> items = [];
  Map<String, dynamic> data = {};
}
```

### Generated Code
For each annotated class, the generator creates:
- A `{ClassName}Variables` class containing ModelVariable instances
- An extension that adds a `.variables` property to your class

## Additional Information

- **Issues**: Report bugs and feature requests on [GitHub](https://github.com/your_username/dart_setters_getters_generator/issues)
- **Contributing**: Contributions are welcome! Please read our contributing guidelines
- **License**: This package is licensed under the MIT License

## Example

See the `/example` folder for a complete example showing all features of the package.
