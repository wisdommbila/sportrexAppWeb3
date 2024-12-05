import 'package:sportRex/core/util/appUtil/helper.dart';

///General Class to validate different user eg Password,Email and more
class Validator {
  static const String _fullNamePattern = r'^[a-z A-Z,.\-]+$';
  static const String phonePattern = r'(^(?:[+0]9)?[0-9]{10,11}$)';
  static const String _emailPattern =
      r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';

  static const _passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';

  static final RegExp _phoneRegExp = RegExp(phonePattern);
  static final RegExp _emailRegex = RegExp(_emailPattern);
  static final RegExp _fullNameRegex = RegExp(_fullNamePattern);
  static final RegExp _passwordRegex = RegExp(_passwordPattern);

  static String? validateEmail(value) {
    if (isEmpty(value)) {
      return 'email is required';
    } else if (!_emailRegex.hasMatch(value)) {
      return 'valid email is required';
    }
    return null;
  }

  static String? validatePhoneNumber(value) {
    if (isEmpty(value) || value!.length == 0) {
      return 'enter phone number';
    }

    if (!_phoneRegExp.hasMatch(value)) {
      return 'enter valid phone number';
    }

    if (value!.length > 11) {
      return 'enter valid phone number';
    }

    return null;
  }

  static String? validateLoginField(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }
    //if value is integer validate number else validate email
    if (isValueInt(value)) {
      return validatePhoneNumber(value);
    } else {
      return validateEmail(value);
    }
  }

  static String? validateName(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }

    List<String> splitName = value.split(" ");

    if (splitName.length >= 2) {
      return 'Enter Single Name';
    }

    if (!_fullNameRegex.hasMatch(value.toString().trim())) {
      return 'Enter valid name';
    }

    return null;
  }

  static String? validateSeedPharse(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }

    return null;
  }

  static String? validateEmptyField(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }

    return null;
  }

  static String? validatePrivateKey(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }

    if (value.toString().trim().length < 2) {
      return 'Enter a valid private key ';
    }

    return null;
  }

  static String? validateWalletAddress(value) {
    if (isEmpty(value)) {
      return 'This field is required';
    }

    if (value.toString().trim().length < 2) {
      return 'Enter a valid wallet address';
    }

    return null;
  }

 static bool isValidEthereumAddress(String address) {
    if (address.isEmpty) return false;
    if (!RegExp(r'^0x[0-9a-fA-F]{40}$').hasMatch(address)) return false;

    // Optionally, you can check for a checksummed address
    if (address != address.toLowerCase() && address != address.toUpperCase()) {
      return isChecksumAddress(address);
    }

    return true;
  }

  static bool isChecksumAddress(String address) {
    address = address.replaceFirst('0x', '');
    String hash = address.toLowerCase();
    for (int i = 0; i < address.length; i++) {
      if (address[i] != hash[i]) return true;
    }
    return false;
  }

  static String? validatePassword(value) {
    if (isEmpty(value)) {
      return 'Please enter your password';
    }

    if (value.toString().trim().length < 6) {
      return 'Password Must be greater than 6';
    }

    if (!_passwordRegex.hasMatch(value.toString().trim())) {
      return 'Password must contain capital letter,number,special char';
    }

    return null;
  }

  static String? validateConfirmPassword(confirmPassword, password) {
    if (validatePassword(password) != null) {
      return null;
    }

    if (validatePassword(confirmPassword) != null) {
      return validatePassword(confirmPassword);
    }

    if (confirmPassword.toString().trim() != password.toString().trim()) {
      return "Password does not match";
    }

    return null;
  }

  ///Add country code to the number
  static String? formatNumber(String? number) {
    if (isEmpty(number)) {
      return null;
    }
    if (number!.length < 11) {
      return null;
    }

    if (number.startsWith("0")) {
      return number.replaceFirst("0", "+234");
    }

    return null;
  }

  static String? validatePin(String? value, {int validLength = 6}) {
    if (isEmpty(value)) {
      return 'Please enter your pin';
    }

    if (value!.length != validLength) {
      return 'Enter Valid Pin';
    }

    return null;
  }

  ///Validate for pin [6 is a default pin for [venpay]
  static bool isPinValid(int pinLength, {int validLength = 6}) {
    return (validLength == pinLength);
  }
}
