// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SettersGettersGenerator
// **************************************************************************

import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'dart_setters_getters_generator_example.dart';

class PersonVariables {
  PersonVariables(this._model);

  final Person _model;

  late final name = ModelVariable<String>(
    () => _model.name,
    (value) => _model.name = value,
  );
  late final age = ModelVariable<int>(
    () => _model.age,
    (value) => _model.age = value,
  );
  late final email = ModelVariable<String>(
    () => _model.email,
    (value) => _model.email = value,
  );
  late final isActive = ModelVariable<bool>(
    () => _model.isActive,
    (value) => _model.isActive = value,
  );
}

extension PersonSettersGettersExtension on Person {
  PersonVariables get variables => PersonVariables(this);
}

class ProductVariables {
  ProductVariables(this._model);

  final Product _model;

  late final title = ModelVariable<String>(
    () => _model.title,
    (value) => _model.title = value,
  );
  late final price = ModelVariable<double>(
    () => _model.price,
    (value) => _model.price = value,
  );
  late final quantity = ModelVariable<int>(
    () => _model.quantity,
    (value) => _model.quantity = value,
  );
  late final description = ModelVariable<String>(
    () => _model.description,
    (value) => _model.description = value,
  );
}

extension ProductSettersGettersExtension on Product {
  ProductVariables get variables => ProductVariables(this);
}
