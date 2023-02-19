/// CColor Model definition
class CColor {
  /// Create color object
  CColor({
    required this.color,
    this.clientID = '0',
  });

  /// Color
  final String color;

  /// Client ID
  final String clientID;

  /// Get JSON object
  Map<String, String> toJson() {
    return <String, String>{
      'color': color,
      'clientID': clientID,
    };
  }
}
