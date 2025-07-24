// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SettersGettersGenerator
// **************************************************************************

import 'dart_setters_getters_generator_example.dart';
import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'package:dart_setters_getters_generator/src/custom_types.dart';

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
  late final address = ModelVariable<Address>(
    () => _model.address,
    (value) => _model.address = value,
  );
  late final contact = ModelVariable<Contact>(
    () => _model.contact,
    (value) => _model.contact = value,
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
  late final category = ModelVariable<Category>(
    () => _model.category,
    (value) => _model.category = value,
  );
  late final tags = ModelVariable<List<Category>>(
    () => _model.tags,
    (value) => _model.tags = value,
  );
}

extension ProductSettersGettersExtension on Product {
  ProductVariables get variables => ProductVariables(this);
}
