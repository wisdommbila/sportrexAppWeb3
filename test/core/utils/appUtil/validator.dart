// import 'package:flutter_test/flutter_test.dart';
// import 'package:sportRex/core/util/appUtil/validator.dart';

// void main() {
//   setUpAll(() {});
//   tearDownAll(() {});

//   group("Email Validator", () {
//     test("should test for email ", () {
//       final result = Validator.validateEmail("");
//       expect(result, "email is required");
//     });

//     test("should test for email null ", () {
//       final result = Validator.validateEmail(null);
//       expect(result, "email is required");
//     });

//     test("should test for invalid email ", () {
//       final result = Validator.validateEmail("ifeanyiagala");
//       expect(result, "valid email is required");
//     });
//   });

//   group("Name Validator", () {
//     test("should test for null ", () {
//       final result = Validator.validateName(null);
//       expect(result, "This field is required");
//     });

//     test("should test for empty name ", () {
//       final result = Validator.validateName("");
//       expect(result, "This field is required");
//     });

//     test("should test for double name ", () {
//       final result = Validator.validateName("Agalaba Ifeanyi");
//       expect(result, "Enter Single Name");
//     });

//     test("should test for invalid  name ", () {
//       final result = Validator.validateName("Agalaba123@");
//       expect(result, "Enter valid name");
//     });

//     test("should test for valid  name ", () {
//       final result = Validator.validateName("Agalaba");
//       expect(result, null);
//     });
//   });

//   group("Address Validator", () {
//     test("should test for null ", () {
//       final result = Validator.validateAddress(null);
//       expect(result, "This field is required");
//     });

//     test("should test for valid address ", () {
//       final result = Validator.validateAddress("1");
//       expect(result, "Enter a valid address");
//     });

//     test("should test for valid address", () {
//       final result = Validator.validateAddress("28 koya lane ejigbo");
//       expect(result, null);
//     });
//   });

//   group("PhoneNumber Validator", () {
//     test("should test for null number ", () {
//       final result = Validator.validatePhoneNumber(null);
//       expect(result, "enter phone number");
//     });

//     test("should test for empty number", () {
//       final result = Validator.validatePhoneNumber(null);
//       expect(result, "enter phone number");
//     });

//     test("should test for invalid number", () {
//       final result = Validator.validatePhoneNumber("ifeanyiagala");
//       expect(result, "enter valid phone number");
//     });
//     test("should test for long number", () {
//       final result = Validator.validatePhoneNumber("090662692333");
//       expect(result, "enter valid phone number");
//     });
//   });

//   group("Password Validator", () {
//     test("should test for null password ", () {
//       final result = Validator.validatePassword(null);
//       expect(result, "Please enter your password");
//     });

//     test("should for password less than 6", () {
//       final result = Validator.validatePassword("pass");
//       expect(result, "Password Must be greater than 6");
//     });

//     test("should for password more than 6 but doesn't have special char ", () {
//       final result = Validator.validatePassword("password");
//       expect(
//           result, "Password must contain capital letter,number,special char");
//     });

//     test("should for password more than 6 but doesn't have has char no number ",
//         () {
//       final result = Validator.validatePassword("password@");
//       expect(
//           result, "Password must contain capital letter,number,special char");
//     });
//     test(
//         "should for password more than 6 but doesn't have has char , number no capital",
//         () {
//       final result = Validator.validatePassword("password@1");
//       expect(
//           result, "Password must contain capital letter,number,special char");
//     });
//     test("should for password that is 6 and have all", () {
//       final result = Validator.validatePassword("Pa123@");
//       expect(result, null);
//     });
//     test("should for password more than  6 and have all", () {
//       final result = Validator.validatePassword("Pass123@");
//       expect(result, null);
//     });
//   });

//   group("Confirm Password", () {
//     test("confirm password stay silent[null] when password hasn't match", () {
//       final result = Validator.validateConfirmPassword("pass", "password123@");
//       expect(result, null);
//     });

//     test("confirm password does not meet criteria", () {
//       final result =
//           Validator.validateConfirmPassword("Pass123", "Password123@");
//       expect(
//           result, 'Password must contain capital letter,number,special char');
//     });

//     test("confirm password meet criteria", () {
//       final result =
//           Validator.validateConfirmPassword("Pass123@", "Password123@");
//       expect(result, 'Password does not match');
//     });

//     test("confirm password does not match", () {
//       final result =
//           Validator.validateConfirmPassword("Pass123@", "Password123@");
//       expect(result, 'Password does not match');
//     });

//     test("confirm password match but does not meet criteria", () {
//       final result =
//           Validator.validateConfirmPassword("password123@", "password123@");
//       expect(result, null);
//     });

//     test("confirm password match and meet criteria", () {
//       final result =
//           Validator.validateConfirmPassword("Password123@", "Password123@");
//       expect(result, null);
//     });
//   });

//   group("Full Name Validator", () {
//     test("should test for null number ", () {
//       final result = Validator.validatePhoneNumber(null);
//       expect(result, "enter phone number");
//     });

//     test("should test for empty number", () {
//       final result = Validator.validatePhoneNumber(null);
//       expect(result, "enter phone number");
//     });

//     test("should test for invalid number", () {
//       final result = Validator.validatePhoneNumber("ifeanyiagala");
//       expect(result, "enter valid phone number");
//     });
//   });

//   group("Pin Validator", () {
//     test("should test for null number ", () {
//       final result = Validator.isPinValid(4);
//       expect(result, false);
//     });

//     test("should test for null number ", () {
//       final result = Validator.isPinValid(6);
//       expect(result, true);
//     });

//     test("should test for null number ", () {
//       final result = Validator.isPinValid(6, validLength: 4);
//       expect(result, false);
//     });

//     test("should test for null number ", () {
//       final result = Validator.isPinValid(6, validLength: 6);
//       expect(result, true);
//     });

//     test("Pin is not complete ", () {
//       final result = Validator.isPinValid(4, validLength: 6);
//       expect(result, false);
//     });
//   });

//   group("Format Number", () {
//     test("should test for invalid number", () {
//       final result = Validator.formatNumber(null);
//       expect(result, null);
//     });

//     test("should test for wrong number", () {
//       final result = Validator.formatNumber("9066269246");
//       expect(result, null);
//     });

//     test("should test for incomplete number", () {
//       final result = Validator.formatNumber("906626924");
//       expect(result, null);
//     });

//     test("should return formated number", () {
//       final result = Validator.formatNumber("09066269233");
//       expect(result, "+2349066269233");
//     });
//   });

//   group("Validate LoginField", () {
//     test("should test for null  ", () {
//       final result = Validator.validateLoginField(null);
//       expect(result, "Enter Valid");
//     });

//     test("should test for empty number", () {
//       final result = Validator.validatePhoneNumber(null);
//       expect(result, "enter phone number");
//     });

//     test("should test for invalid number", () {
//       final result = Validator.validatePhoneNumber("ifeanyiagala");
//       expect(result, "enter valid phone number");
//     });
//   });



// }
