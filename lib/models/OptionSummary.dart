import 'package:flutter/cupertino.dart';

class OptionSummary {
  String optionName;
  List<String> playerIds;
  int totalMoney;
  OptionSummary(
      {@required this.optionName,
      @required this.playerIds,
      @required this.totalMoney});
}
