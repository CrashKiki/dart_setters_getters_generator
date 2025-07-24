/// Generic variable wrapper that provides getter/setter access to model fields
/// This class is used by the AutoVariables code generator
class ModelVariable<T> {
  ModelVariable(this._getter, this._setter);

  final T Function() _getter;
  final void Function(T) _setter;

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
}
