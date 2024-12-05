import '../commonLibs/common_libs.dart';

extension ToBoolean on String {
  bool toBoolean() {
    return (toLowerCase() == "true")
        ? true
        : (toLowerCase() == "false")
            ? false
            : throw UnsupportedError('Not supported');
  }
}

extension Parameters on String {
  ///Append your string to the parameter provided
  String encodeParams(Map<String, String> params) {
    var attach = '';
    params.forEach((key, value) {
      if (value.isNotEmpty && value != 'null') {
        var urlEncode = Uri.encodeComponent(value);
        attach += '${attach == '' ? '?' : '&'}$key=$urlEncode';
      }
    });
    return "$this$attach";
  }
}

extension BuildContextPlus on BuildContext {
  /// Returns a SizedBox with a responsive width.
  SizedBox hSpace(double value) => SizedBox(width: dx(value));

  /// Returns a SizedBox with a responsive height.
  SizedBox vSpace(double value) => SizedBox(height: dy(value));

  /// Returns the amount of the passed value with respect to the design height.
  double dy(double value) => MediaQuery.of(this).size.height * value / 812;

  /// Returns the amount of the passed value with respect to the design width.
  double dx(double value) => MediaQuery.of(this).size.width * value / 375;
}
