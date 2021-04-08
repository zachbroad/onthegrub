class Validate {
  static String email(String email) {
    bool at = false;
    bool fullStop = false;
    email.runes.forEach(
      (int rune) {
        var char = new String.fromCharCode(rune);
        if (char == '@') {
          at = true;
        }
        if (char == '.') {
          fullStop = true;
        }
      },
    );
    if (email.length < 3) return 'Email must not be empty';
    if (at && fullStop) {
      return null;
    }
    return 'Please enter a valid email';
  }

  static String confirmEmail(String email, String confirmEmail) {
    if (email != confirmEmail && (email.contains('@') && email.contains('.'))) {
      return 'Emails do not match';
    } else {
      return null;
    }
  }

  static String name(String value) {
    if (value.length < 2) return 'Name must be longer than 1 character.';
    if (value.length > 120)
      return 'Name must be less than 120 characters';
    else
      return null;
  }

  static String newName(String newName, String oldName) {
    if (newName.length > 1) return 'Name must be longer than 1 character';
    if (newName == oldName) {
      return 'Names must not match';
    } else {
      return null;
    }
  }

  static String phone(String phone) {
    RegExp regExp = RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$');
    if (!regExp.hasMatch(phone)) return 'Please enter a valid US phone number';
    return null;
  }

  static String password(String value) {
    if (value.trim().length < 8) return 'Please enter a password greater than 8 characters';
    // REGEX MATCH
    return null;
  }

  static String confirmPassword(String password, String confirmPassword) {
    if (password.length < 1) return 'Please confirm your password';
    if (password != confirmPassword) return 'Passwords do not match';
    return null;
  }
}
