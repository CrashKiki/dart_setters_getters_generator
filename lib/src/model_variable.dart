/// Generic variable wrapper that provides getter/setter access to model fields
/// This class is used by the AutoVariables code generator
class ModelVariable<T> {
  ModelVariable(this._getter, this._setter, this._fieldName);

  final T Function() _getter;
  final void Function(T) _setter;
  final String _fieldName;

  /// Get the current value of the field
  T get value => _getter();

  /// Set a new value for the field
  set value(T newValue) {
    final oldValue = _getter();
    if (oldValue != newValue) {
      _setter(newValue);
    }
  }

  /// Alternative getter method
  T get() => _getter();

  /// Alternative setter method
  void set(T newValue) {
    value = newValue;
  }

  /// Utility method to infer database key from field name
  String _inferKeyFromFieldName(String fieldName) {
    final snakeCase = fieldName.replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)!.toLowerCase()}',
    );
    return 'c_$snakeCase';
  }
}
