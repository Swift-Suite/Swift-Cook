// File: serializable.dart
// Author: @tdimhcsleumas

abstract class Serializable {
  List<String> getKeys();
  Map<String, dynamic> jsonSerialize();
  void initializeFromJson(Map<String, dynamic> json);
  String toString() {
    return this.jsonSerialize().toString();
  }
}
