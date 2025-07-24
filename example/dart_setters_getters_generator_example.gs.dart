// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dart_setters_getters_generator_example.dart';

// **************************************************************************
// SettersGettersGenerator
// **************************************************************************

class PersonVariables {
  PersonVariables(this._model);

  final Person _model;

  late final name = ModelKeyVariable<String>(
    'my_name',
    () => _model.name,
    (value) => _model.name = value,
  );
  late final age = ModelKeyVariable<int>(
    'user_age',
    () => _model.age,
    (value) => _model.age = value,
  );
  late final email = ModelKeyVariable<String>(
    'email_address',
    () => _model.email,
    (value) => _model.email = value,
  );
  late final isActive = ModelVariable<bool>(
    () => _model.isActive,
    (value) => _model.isActive = value,
  );
  late final address = ModelKeyVariable<Address>(
    'home_address',
    () => _model.address,
    (value) => _model.address = value,
  );
  late final contact = ModelVariable<Contact>(
    () => _model.contact,
    (value) => _model.contact = value,
  );

  /// List containing only variables with includeInMap = true
  late final List<ModelKeyVariable> apiKeyVariables = [
    name,
    age,
    email,
    address,
  ];

  /// Convert apiKeyVariables to a Map<String, dynamic>
  Map<String, dynamic> get apiKeyMap => {
        for (final variable in apiKeyVariables)
          variable.key: variable.value is ApiConvertible
              ? (variable.value as ApiConvertible).toApiValue()
              : variable.value,
      };
}

extension PersonSettersGettersExtension on Person {
  PersonVariables get variables => PersonVariables(this);
}

class ProductVariables {
  ProductVariables(this._model);

  final Product _model;

  late final title = ModelKeyVariable<String>(
    'product_title',
    () => _model.title,
    (value) => _model.title = value,
  );
  late final price = ModelKeyVariable<double>(
    'product_price',
    () => _model.price,
    (value) => _model.price = value,
  );
  late final quantity = ModelKeyVariable<int>(
    'stock_quantity',
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

  /// List containing only variables with includeInMap = true
  late final List<ModelKeyVariable> apiKeyVariables = [
    title,
    price,
    quantity,
  ];

  /// Convert apiKeyVariables to a Map<String, dynamic>
  Map<String, dynamic> get apiKeyMap => {
        for (final variable in apiKeyVariables)
          variable.key: variable.value is ApiConvertible
              ? (variable.value as ApiConvertible).toApiValue()
              : variable.value,
      };
}

extension ProductSettersGettersExtension on Product {
  ProductVariables get variables => ProductVariables(this);
}
