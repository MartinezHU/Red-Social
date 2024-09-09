class ModelValidationException implements Exception {
  final String message;

  ModelValidationException(this.message);

  @override
  String toString() => "ModelValidationException: $message";
}

void validateModelFields(Map<String, dynamic> fields) {
  fields.forEach((fieldName, value) {
    if (value == null) {
      throw ModelValidationException('El campo $fieldName no puede ser null.');
    }
  });
}
