import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'annotations.dart';

Builder settersGettersBuilder(BuilderOptions options) =>
    LibraryBuilder(SettersGettersGenerator(),
        generatedExtension: '.gs.g.dart');

class SettersGettersGenerator extends GeneratorForAnnotation<GetterSetterVariables> {
  @override
  TypeChecker get typeChecker => TypeChecker.fromRuntime(GetterSetterVariables);

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

    // Get all non-static, non-final fields that are settable
    final fields = element.fields
        .where((field) =>
            !field.isStatic &&
            !field.isFinal &&
            !field.hasIgnore &&
            !field.isConst &&
            field.setter != null &&  // Has a setter (not getter-only)
            !field.isSynthetic)      // Exclude synthetic fields
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
    final imports = <String>{};

    // Always add the main package import
    imports.add("import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';");

    // Add import for the original file containing the annotated classes
    final sourceUri = library.element.source.uri;
    if (sourceUri.scheme == 'package') {
      imports.add("import '${sourceUri.toString()}';");
    } else {
      // For local files, use relative import
      final fileName = sourceUri.pathSegments.last;
      imports.add("import '$fileName';");
    }

    // Generate code for all annotated classes and collect additional imports
    final annotatedElements = library.annotatedWith(typeChecker);
    final generatedCodeParts = <String>[];

    for (final annotatedElement in annotatedElements) {
      if (annotatedElement.element is ClassElement) {
        final classElement = annotatedElement.element as ClassElement;

        // Collect imports for field types
        _collectFieldTypeImports(classElement, imports);

        final generatedCode = generateForAnnotatedElement(
          annotatedElement.element,
          annotatedElement.annotation,
          buildStep,
        );
        generatedCodeParts.add(generatedCode);
      }
    }

    // Write all imports at the top
    for (final import in imports.toList()..sort()) {
      buffer.writeln(import);
    }
    buffer.writeln('');

    // Write all generated code
    for (final code in generatedCodeParts) {
      buffer.writeln(code);
      buffer.writeln('');
    }

    return buffer.toString();
  }

  void _collectFieldTypeImports(ClassElement classElement, Set<String> imports) {
    final fields = classElement.fields
        .where((field) => !field.isStatic && !field.isFinal && !field.hasIgnore);

    for (final field in fields) {
      _addImportsForType(field.type, imports);
    }
  }

  void _addImportsForType(DartType type, Set<String> imports) {
    // Handle the main type
    final element = type.element;
    if (element != null && element.library != null) {
      final library = element.library!;
      final libraryUri = library.source.uri;

      // Only add import if it's not from dart:core and not the current library
      if (!libraryUri.toString().startsWith('dart:core') &&
          !libraryUri.toString().startsWith('dart:_internal')) {
        if (libraryUri.scheme == 'package') {
          imports.add("import '${libraryUri.toString()}';");
        } else if (libraryUri.scheme == 'file') {
          // For local files, try to get relative path
          final fileName = libraryUri.pathSegments.last;
          if (fileName.isNotEmpty) {
            imports.add("import '$fileName';");
          }
        }
      }
    }

    // Handle generic type arguments (like List<CustomClass>, Map<String, CustomClass>)
    if (type is ParameterizedType) {
      for (final typeArg in type.typeArguments) {
        _addImportsForType(typeArg, imports);
      }
    }
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
