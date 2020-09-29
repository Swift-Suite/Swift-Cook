// File: serializable.dart
// Author: @tdimhcsleumas

abstract class Serializable {
  List<String> getKeys();
  Map<String, dynamic> jsonSerialize();
  String toString() {
    return this.jsonSerialize().toString();
  }
}
