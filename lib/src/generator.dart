import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotations.dart';

Builder settersGettersBuilder(BuilderOptions options) =>
    LibraryBuilder(SettersGettersGenerator(),
        generatedExtension: '.setters_getters.g.dart');

class SettersGettersGenerator extends GeneratorForAnnotation<AutoVariables> {
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
      final fieldType = field.type.getDisplayString();

      buffer.writeln('  late final $fieldName = ModelVariable<$fieldType>(');
      buffer.writeln('    () => _model.$fieldName,');
      buffer.writeln('    (value) => _model.$fieldName = value,');
      buffer.writeln('  );');
    }

    buffer.writeln('}');
    buffer.writeln('');

    // Generate extension on the original class
    buffer.writeln('extension ${className}SettersGettersExtension on $className {');
    buffer.writeln('  ${className}Variables get variables => ${className}Variables(this);');
    buffer.writeln('}');

    return buffer.toString();
  }

  @override
  String generate(LibraryReader library, BuildStep buildStep) {
    final buffer = StringBuffer();

    // Add imports at the top of the file only once
    buffer.writeln("import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';");

    // Add import for the original file containing the annotated classes
    final sourceUri = library.element.source.uri;
    if (sourceUri.scheme == 'package') {
      buffer.writeln("import '${sourceUri.toString()}';");
    } else {
      // For local files, use relative import
      final fileName = sourceUri.pathSegments.last;
      buffer.writeln("import '$fileName';");
    }
    buffer.writeln('');

    // Generate code for all annotated classes
    final annotatedElements = library.annotatedWith(typeChecker);
    for (final annotatedElement in annotatedElements) {
      final generatedCode = generateForAnnotatedElement(
        annotatedElement.element,
        annotatedElement.annotation,
        buildStep,
      );
      buffer.writeln(generatedCode);
      buffer.writeln('');
    }

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
