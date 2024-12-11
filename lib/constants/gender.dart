enum Gender {
  notBinary(0, 'Not Binary'),
  female(1, 'Female'),
  male(2, 'Male');

  final int value;
  final String label;
  const Gender(this.value, this.label);

  static Gender fromValue(int value) {
    switch (value) {
      case 1:
        return Gender.female;
      case 2:
        return Gender.male;
      default:
        throw Exception('Invalid gender value: $value');
    }
  }

  static int toValue(Gender gender) {
    return gender.value;
  }
}
