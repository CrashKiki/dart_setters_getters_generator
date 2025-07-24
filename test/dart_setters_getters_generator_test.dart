import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'package:dart_setters_getters_generator/src/custom_types.dart';
import 'package:test/test.dart';

part 'dart_setters_getters_generator_test.gs.dart';

@GetterSetterVariables()
class TestModel {
  TestModel(this.name);
  String name;
  int count = 0;
  bool isEnabled = false;
  double value = 0.0;
  final finalVariable = 'final value';
  List<String> tags = [];
  Map<String, dynamic> metadata = {};
  Address address = Address();
  Contact contact = Contact();
  List<Category> categories = [];
}

void main() {
  group('AutoVariables Generator Tests', () {
    late TestModel model;

    setUp(() {
      model = TestModel('default');
    });

    test('should generate variables with correct initial values', () {
      expect(model.variables.name.value, equals('default'));
      expect(model.variables.count.value, equals(0));
      expect(model.variables.isEnabled.value, equals(false));
      expect(model.variables.value.value, equals(0.0));
    });

    test('should update values through generated variables', () {
      model.variables.name.value = 'test name';
      model.variables.count.value = 42;
      model.variables.isEnabled.value = true;
      model.variables.value.value = 3.14;

      expect(model.name, equals('test name'));
      expect(model.count, equals(42));
      expect(model.isEnabled, equals(true));
      expect(model.value, equals(3.14));
    });

    test('should reflect model changes in variables', () {
      model.name = 'direct update';
      model.count = 100;

      expect(model.variables.name.value, equals('direct update'));
      expect(model.variables.count.value, equals(100));
    });

    test('should support alternative getter/setter methods', () {
      model.variables.name.set('using set method');
      expect(model.variables.name.get(), equals('using set method'));
      expect(model.name, equals('using set method'));
    });

    test('should only update when value actually changes', () {
      final originalValue = model.variables.count.value;

      // Set to same value - should not trigger change
      model.variables.count.value = originalValue;
      expect(model.variables.count.value, equals(originalValue));

      // Set to different value - should trigger change
      model.variables.count.value = originalValue + 1;
      expect(model.variables.count.value, equals(originalValue + 1));
    });

    group('ModelVariable functionality', () {
      test('should handle string fields correctly', () {
        final variable = model.variables.name;

        variable.value = 'test string';
        expect(variable.value, equals('test string'));
        expect(model.name, equals('test string'));
      });

      test('should handle numeric fields correctly', () {
        final intVariable = model.variables.count;
        final doubleVariable = model.variables.value;

        intVariable.value = 123;
        doubleVariable.value = 45.67;

        expect(intVariable.value, equals(123));
        expect(doubleVariable.value, equals(45.67));
        expect(model.count, equals(123));
        expect(model.value, equals(45.67));
      });

      test('should handle boolean fields correctly', () {
        final variable = model.variables.isEnabled;

        variable.value = true;
        expect(variable.value, equals(true));
        expect(model.isEnabled, equals(true));

        variable.value = false;
        expect(variable.value, equals(false));
        expect(model.isEnabled, equals(false));
      });

      test('should handle list fields correctly', () {
        final variable = model.variables.tags;

        variable.value = ['tag1', 'tag2'];
        expect(variable.value, equals(['tag1', 'tag2']));
        expect(model.tags, equals(['tag1', 'tag2']));

        variable.value.add('tag3');
        expect(variable.value, equals(['tag1', 'tag2', 'tag3']));
        expect(model.tags, equals(['tag1', 'tag2', 'tag3']));
      });

      test('should handle map fields correctly', () {
        final variable = model.variables.metadata;

        variable.value = {'key1': 'value1', 'key2': 2};
        expect(variable.value, equals({'key1': 'value1', 'key2': 2}));
        expect(model.metadata, equals({'key1': 'value1', 'key2': 2}));

        variable.value['key3'] = 'value3';
        expect(variable.value, equals({'key1': 'value1', 'key2': 2, 'key3': 'value3'}));
        expect(model.metadata, equals({'key1': 'value1', 'key2': 2, 'key3': 'value3'}));
      });

      test('should handle custom object fields correctly', () {
        final addressVariable = model.variables.address;
        final contactVariable = model.variables.contact;
        final categoriesVariable = model.variables.categories;

        // Test Address object
        addressVariable.value = Address(
          street: '123 Main St',
          city: 'Anytown',
          zipCode: '12345',
          country: 'USA'
        );
        expect(addressVariable.value.street, equals('123 Main St'));
        expect(addressVariable.value.city, equals('Anytown'));
        expect(addressVariable.value.zipCode, equals('12345'));
        expect(addressVariable.value.country, equals('USA'));

        // Test Contact object
        contactVariable.value = Contact(
          phone: '+1-555-123-4567',
          email: 'john.doe@example.com'
        );
        expect(contactVariable.value.phone, equals('+1-555-123-4567'));
        expect(contactVariable.value.email, equals('john.doe@example.com'));

        // Test Category list
        categoriesVariable.value = [
          Category(id: 1, name: 'Category1', description: 'First category'),
          Category(id: 2, name: 'Category2', description: 'Second category')
        ];
        expect(categoriesVariable.value.length, equals(2));
        expect(categoriesVariable.value[0].name, equals('Category1'));
        expect(categoriesVariable.value[1].name, equals('Category2'));
        expect(categoriesVariable.value[0].id, equals(1));
        expect(categoriesVariable.value[1].id, equals(2));
      });
    });
  });

  group('ModelVariable direct tests', () {
    test('should create ModelVariable with getter and setter', () {
      String testValue = 'initial';

      final variable = ModelVariable<String>(
        () => testValue,
        (value) => testValue = value,
      );

      expect(variable.value, equals('initial'));

      variable.value = 'updated';
      expect(variable.value, equals('updated'));
      expect(testValue, equals('updated'));
    });

    test('should use alternative methods correctly', () {
      int testValue = 10;

      final variable = ModelVariable<int>(
        () => testValue,
        (value) => testValue = value,
      );

      expect(variable.get(), equals(10));

      variable.set(20);
      expect(variable.get(), equals(20));
      expect(testValue, equals(20));
    });
  });
}
