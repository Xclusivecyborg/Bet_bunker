class Validations {
  static String? validateName(String value) {
    if (value.isEmpty) return '  Field is required.';
    final RegExp nameExp = RegExp(r'^[A-za-zğüşöçİĞÜŞÖÇ ]+$');
    if (!nameExp.hasMatch(value)) {
      return '  Please enter only alphabetical characters.';
    }
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) return '  Email is required.';
    final RegExp nameExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (!nameExp.hasMatch(value)) {
      return 'Invalid email address';
    }
  }

  static String? validateNumber(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return ' Field is required.';
    final RegExp nameExp = RegExp('([0-9]+(\.[0-9]+)?)');
    if (!nameExp.hasMatch(value) && isRequried) return 'Invalid Number';
  }

  static String? validateString(String? value, [bool isRequried = true]) {
    if (value!.isEmpty && isRequried) return '  Field is required.';
    // final RegExp nameExp = new RegExp('([0-9]+(\.[0-9]+)?)');
    // if (!nameExp.hasMatch(value) && isRequried) return 'Invalid Number';
  }

  static String? validatePassword(String? value) {
    final RegExp atleastOneLowerCase = RegExp(r"^(?=.*[a-z])");
    final RegExp atLeastOneUpperCase = RegExp(r"^(?=.*[A-Z])");
    final RegExp atleastOneDigit = RegExp(r"^(?=.*?[0-9])");
    if (value!.isEmpty || value.length < 8) {
      return '  Password must be at least 8 characters long';
    } else if (!atleastOneLowerCase.hasMatch(value)) {
      return 'Must contain at least one lowercase character';
    } else if (!atLeastOneUpperCase.hasMatch(value)) {
      return 'Must contain at least one Uppercase character.';
    } else if (!atleastOneDigit.hasMatch(value)) {
      return 'Must contain at least one Number.';
    }
  }
}
