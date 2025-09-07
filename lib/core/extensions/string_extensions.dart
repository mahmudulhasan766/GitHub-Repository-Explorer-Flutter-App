extension StringExtensions on String {
  /// Replaces placeholders with values provided in [params].
  /// Placeholders should be in the format `{key}`.
  String requestParams(Map<String, dynamic> params) {
    final formattedString = "$this \n$params";

    return formattedString;
  }
}
