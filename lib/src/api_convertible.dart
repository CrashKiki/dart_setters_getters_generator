/// Mixin that objects can implement to provide custom conversion logic
/// for the apiKeyMap in generated code
mixin ApiConvertible {
  /// Convert this object to a value suitable for API serialization
  dynamic toApiValue();
}

