import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotations.dart';

Builder autoVariablesBuilder(BuilderOptions options) =>
    SharedPartBuilder([AutoVariablesGenerator()], 'auto_variables');

class AutoVariablesGenerator extends GeneratorForAnnotation<AutoVariables> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        'AutoVariables can only be applied to classes',
        element: element,
      );
    }

    final className = element.name;
    final buffer = StringBuffer();

    // Add import for the shared ModelVariable class
    buffer.writeln("import 'package:auto_variables_generator/auto_variables_generator.dart';");
    buffer.writeln('');

    // Get all non-static, non-final fields
    final fields = element.fields
        .where((field) => !field.isStatic && !field.isFinal && !field.hasIgnore)
        .toList();

    // Generate the variables container class
    buffer.writeln('class ${className}Variables {');
    buffer.writeln('  ${className}Variables(this._model);');
    buffer.writeln('');
    buffer.writeln('  final $className _model;');
    buffer.writeln('');

    // Generate variable objects for each field using the shared ModelVariable class
    for (final field in fields) {
      final fieldName = field.name;
      final fieldType = field.type.getDisplayString(withNullability: true);

      buffer.writeln('  late final $fieldName = ModelVariable<$fieldType>(');
      buffer.writeln('    () => _model.$fieldName,');
      buffer.writeln('    (value) => _model.$fieldName = value,');
      buffer.writeln('    \'$fieldName\',');
      buffer.writeln('  );');
    }

    buffer.writeln('}');
    buffer.writeln('');

    // Generate extension on the original class
    buffer.writeln('extension ${className}AutoVariablesExtension on $className {');
    buffer.writeln('  ${className}Variables get variables => ${className}Variables(this);');
    buffer.writeln('}');

    return buffer.toString();
  }
}

extension FieldElementExtension on FieldElement {
  bool get hasIgnore {
    return metadata.any((meta) =>
      meta.element?.displayName == 'ignore' ||
      meta.element?.displayName == 'Ignore'
    );
  }
}
