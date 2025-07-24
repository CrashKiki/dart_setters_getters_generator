const getterSetterVariables = GetterSetterVariables();

/// Annotation to mark classes that should have automatic variable generation
class GetterSetterVariables {
  const GetterSetterVariables();
}

class GetterSetterAPIKey {
  const GetterSetterAPIKey({required this.key, this.includeInMap = true});

  final String key;
  final bool includeInMap;
}
