import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotations.dart';

extension FieldElementExtension on FieldElement {
  bool get hasIgnore {
    return metadata.any(
      (meta) =>
          meta.element?.displayName == 'ignore' ||
          meta.element?.displayName == 'Ignore',
    );
  }

  /// Get the key value from GetterSetterAPIKey annotation
  String? get apiKey {
    for (var e in metadata) {
      if (e.element?.displayName == 'GetterSetterAPIKey') {
        return e.computeConstantValue()?.getField('key')?.toStringValue();
      }
    }
    return null;
  }

  /// Get the includeInMap value from GetterSetterAPIKey annotation
  bool get includeInMap {
    for (var e in metadata) {
      if (e.element?.displayName == 'GetterSetterAPIKey') {
        return e.computeConstantValue()?.getField('includeInMap')?.toBoolValue() ?? true;
      }
    }
    return false; // If no annotation found, don't include in map
  }
}

Builder settersGettersBuilder(BuilderOptions options) =>
    PartBuilder([SettersGettersGenerator()], '.gs.dart');

class SettersGettersGenerator
    extends GeneratorForAnnotation<GetterSetterVariables> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    print('XXXX');
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'GetterSetterVariables can only be applied to classes',
        element: element,
      );
    }

    final className = element.name;

    // Get all non-static, non-final fields that are settable
    final fields = element.fields
        .where(
          (field) =>
              !field.isStatic &&
              !field.isFinal &&
              !field.hasIgnore &&
              !field.isConst &&
              field.setter != null &&
              !field.isSynthetic,
        )
        .toList();

    if (fields.isEmpty) {
      return '';
    }

    final buffer = StringBuffer();

    // Generate the variables container class
    buffer.writeln('class ${className}Variables {');
    buffer.writeln('  ${className}Variables(this._model);');
    buffer.writeln('');
    buffer.writeln('  final $className _model;');
    buffer.writeln('');

    // Generate variable objects for each field
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString();

      final apiKey = field.apiKey;
      if (apiKey != null) {
        buffer.writeln(
          '  late final $fieldName = ModelKeyVariable<$fieldType>(',
        );
        buffer.writeln('    \'$apiKey\',');
        buffer.writeln('    () => _model.$fieldName,');
        buffer.writeln('    (value) => _model.$fieldName = value,');
        buffer.writeln('  );');
      } else {
        // Generate regular ModelVariable for other fields
        buffer.writeln('  late final $fieldName = ModelVariable<$fieldType>(');
        buffer.writeln('    () => _model.$fieldName,');
        buffer.writeln('    (value) => _model.$fieldName = value,');
        buffer.writeln('  );');
      }
    }

    // Generate late final list with variables that have includeInMap = true
    final apiKeyFields = fields.where((field) =>
      field.apiKey != null && field.includeInMap).toList();

    if (apiKeyFields.isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('  /// List containing only variables with includeInMap = true');
      buffer.writeln('  late final List<ModelKeyVariable> apiKeyVariables = [');
      for (final field in apiKeyFields) {
        final fieldName = field.name;
        buffer.writeln('    $fieldName,');
      }
      buffer.writeln('  ];');

      buffer.writeln('');
      buffer.writeln('  /// Convert apiKeyVariables to a Map<String, dynamic>');
      buffer.writeln('  Map<String, dynamic> get apiKeyMap => {');
      buffer.writeln('    for (final e in apiKeyVariables)');
      buffer.writeln('      e.key: e.value,');
      buffer.writeln('  };');
    }

    buffer.writeln('}');
    buffer.writeln('');

    // Generate extension on the original class
    buffer.writeln(
      'extension ${className}SettersGettersExtension on $className {',
    );
    buffer.writeln(
      '  ${className}Variables get variables => ${className}Variables(this);',
    );
    buffer.writeln('}');

    return buffer.toString();
  }
}
