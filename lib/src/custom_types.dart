import 'package:dart_setters_getters_generator/dart_setters_getters_generator.dart';

/// Custom classes for testing import detection in the dart_setters_getters_generator package
class Address with ApiConvertible{
  String street = '';
  String city = '';
  String zipCode = '';
  String country = '';

  Address({
    this.street = '',
    this.city = '',
    this.zipCode = '',
    this.country = '',
  });

  @override
  toApiValue() => {
    'street': street,
    'city': city,
    'zipCode': zipCode,
    'country': country,
  };

}

class Contact {
  String phone = '';
  String email = '';
  Address? address;

  Contact({
    this.phone = '',
    this.email = '',
    this.address,
  });
}

class Category {
  String name = '';
  String description = '';
  int id = 0;

  Category({
    this.name = '',
    this.description = '',
    this.id = 0,
  });

  @override
  String toString() => 'Category(id: $id, name: $name, description: $description)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Category &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          id == other.id;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ id.hashCode;
}
