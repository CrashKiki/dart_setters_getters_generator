/// Annotations for the auto variables generator
library auto_variables_annotations;

/// Annotation to mark classes that should have automatic variable generation
class AutoVariables {
  const AutoVariables();
}

/// Annotation to mark fields that should have sync setters generated
class SyncableField {
  const SyncableField({
    this.key,
    this.type = SyncFieldType.string,
  });

  final String? key;
  final SyncFieldType type;
}

class SyncableModel {
  const SyncableModel();
}

enum SyncFieldType {
  string,
  bool,
  date,
  dealerValue,
  accountLocationList,
  dealerERs,
  dealerPQData,
}
