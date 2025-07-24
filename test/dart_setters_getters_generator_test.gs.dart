// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dart_setters_getters_generator_test.dart';

// **************************************************************************
// SettersGettersGenerator
// **************************************************************************

class TestModelVariables {
  TestModelVariables(this._model);

  final TestModel _model;

  late final name = ModelVariable<String>(
    () => _model.name,
    (value) => _model.name = value,
  );
  late final count = ModelVariable<int>(
    () => _model.count,
    (value) => _model.count = value,
  );
  late final isEnabled = ModelVariable<bool>(
    () => _model.isEnabled,
    (value) => _model.isEnabled = value,
  );
  late final value = ModelVariable<double>(
    () => _model.value,
    (value) => _model.value = value,
  );
  late final tags = ModelVariable<List<String>>(
    () => _model.tags,
    (value) => _model.tags = value,
  );
  late final metadata = ModelVariable<Map<String, dynamic>>(
    () => _model.metadata,
    (value) => _model.metadata = value,
  );
  late final address = ModelVariable<Address>(
    () => _model.address,
    (value) => _model.address = value,
  );
  late final contact = ModelVariable<Contact>(
    () => _model.contact,
    (value) => _model.contact = value,
  );
  late final categories = ModelVariable<List<Category>>(
    () => _model.categories,
    (value) => _model.categories = value,
  );
}

extension TestModelSettersGettersExtension on TestModel {
  TestModelVariables get variables => TestModelVariables(this);
}
