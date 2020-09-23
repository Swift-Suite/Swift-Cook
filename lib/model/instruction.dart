// Author: @tdimhcsleumas
import './serializable.dart';

class Instruction extends Serializable {
  static final String kContent = "content";
  static final List<String> _keyList = [kContent];
  String content;

  Instruction(this.content);

  @override
  List<String> getKeys() {
    return _keyList;
  }

  @override
  Map<String, dynamic> jsonSerialize() {
    return {kContent: this.content};
  }
}
