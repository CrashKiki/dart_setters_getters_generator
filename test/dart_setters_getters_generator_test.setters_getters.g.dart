// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// SettersGettersGenerator
// **************************************************************************

import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'dart_setters_getters_generator_test.dart';

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
}

extension TestModelSettersGettersExtension on TestModel {
  TestModelVariables get variables => TestModelVariables(this);
}
