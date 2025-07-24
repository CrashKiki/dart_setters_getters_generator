import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';
import 'package:dart_setters_getters_generator/src/custom_types.dart';

part 'dart_setters_getters_generator_example.gs.dart';

@GetterSetterVariables()
class Person {
  @GetterSetterAPIKey(key: 'my_name')
  String name = '';
  int age = 0;
  String email = '';
  bool isActive = true;
  Address address = Address();
  Contact contact = Contact();

  bool get isAdult => age >= 18; // No variable generated for getters/setters
}

@GetterSetterVariables()
class Product {
  String title = '';
  double price = 0.0;
  int quantity = 0;
  String description = '';
  Category category = Category();
  List<Category> tags = [];
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

  // Test custom object fields
  person.variables.address.value = Address(
    street: '123 Main St',
    city: 'San Francisco',
    zipCode: '94105',
    country: 'USA',
  );

  person.variables.contact.value = Contact(
    phone: '+1-555-123-4567',
    email: 'john.doe@example.com',
    address: person.variables.address.value,
  );

  print('Updated name: ${person.variables.name.value}');
  print('Age: ${person.variables.age.value}');
  print('Email: ${person.variables.email.value}');
  print('Address: ${person.variables.address.value}');
  print('Contact: ${person.variables.contact.value}');
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

  // Test custom object and list of custom objects
  product.variables.category.value = Category(
    id: 1,
    name: 'Electronics',
    description: 'Electronic devices and accessories',
  );

  product.variables.tags.value = [
    Category(id: 10, name: 'Computers', description: 'Computer equipment'),
    Category(id: 11, name: 'Portable', description: 'Portable devices'),
    Category(id: 12, name: 'Business', description: 'Business equipment'),
  ];

  print('Product: ${product.variables.title.value}');
  print('Price: \$${product.variables.price.value}');
  print('Quantity: ${product.variables.quantity.value}');
  print('Description: ${product.variables.description.value}');
  print('Category: ${product.variables.category.value}');
  print('Tags: ${product.variables.tags.value}');

  // Demonstrate that the ModelVariable only updates when values change
  print('\n=== Change Detection Example ===');
  final oldPrice = product.variables.price.value;
  print('Setting price to same value ($oldPrice)...');
  product.variables.price.value = oldPrice; // No change should occur

  print('Setting price to new value...');
  product.variables.price.value = 1299.99;
  print('New price: \$${product.variables.price.value}');

  print('\n=== Custom Object Modification Example ===');
  final currentAddress = person.variables.address.get();
  currentAddress.street = '456 Oak Avenue';
  person.variables.address.set(currentAddress);
  print('Updated address: ${person.variables.address.value}');
}
