/// Custom classes for testing import detection in the dart_setters_getters_generator package
class Address {
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
  String toString() => '$street, $city $zipCode, $country';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Address &&
          runtimeType == other.runtimeType &&
          street == other.street &&
          city == other.city &&
          zipCode == other.zipCode &&
          country == other.country;

  @override
  int get hashCode =>
      street.hashCode ^ city.hashCode ^ zipCode.hashCode ^ country.hashCode;
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

  @override
  String toString() => 'Contact(phone: $phone, email: $email, address: $address)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          email == other.email &&
          address == other.address;

  @override
  int get hashCode => phone.hashCode ^ email.hashCode ^ address.hashCode;
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
