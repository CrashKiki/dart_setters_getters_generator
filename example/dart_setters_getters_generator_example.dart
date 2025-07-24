import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'dart_setters_getters_generator_example.setters_getters.g.dart';



@AutoVariables()
class Person {
  String name = '';
  int age = 0;
  String email = '';
  bool isActive = true;
}

@AutoVariables()
class Product {
  String title = '';
  double price = 0.0;
  int quantity = 0;
  String description = '';
}

void main() {
  // Create a person instance
  final person = Person();

  print('=== Person Example ===');
  print('Initial name: ${person.name}');

  // Use the generated variables to set values
  person.variables.name.value = 'John Doe';
  person.variables.age.value = 30;
  person.variables.email.value = 'john@example.com';

  print('Updated name: ${person.variables.name.value}');
  print('Age: ${person.variables.age.value}');
  print('Email: ${person.variables.email.value}');
  print('Is active: ${person.variables.isActive.value}');

  // Demonstrate using the alternative setter/getter methods
  person.variables.age.set(31);
  print('Age after using set(): ${person.variables.age.get()}');

  print('\n=== Product Example ===');
  final product = Product();

  // Set values using the generated variables
  product.variables.title.value = 'Laptop';
  product.variables.price.value = 999.99;
  product.variables.quantity.value = 10;
  product.variables.description.value = 'High-performance laptop';

  print('Product: ${product.variables.title.value}');
  print('Price: \$${product.variables.price.value}');
  print('Quantity: ${product.variables.quantity.value}');
  print('Description: ${product.variables.description.value}');

  // Demonstrate that the ModelVariable only updates when values change
  print('\n=== Change Detection Example ===');
  final oldPrice = product.variables.price.value;
  print('Setting price to same value ($oldPrice)...');
  product.variables.price.value = oldPrice; // No change should occur

  print('Setting price to new value...');
  product.variables.price.value = 1299.99;
  print('New price: \$${product.variables.price.value}');
}
