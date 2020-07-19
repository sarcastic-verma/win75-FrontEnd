import 'package:flutter/cupertino.dart';

class PlayerSummary {
  String playerId;
  String gameId;
  List optedOptions;
  List acceptedOptions;
  int totalInvestment;
  int profitableInvestment;
  double proportionalGain;
  double totalGain;
  PlayerSummary({
    @required this.gameId,
    @required this.playerId,
    @required this.profitableInvestment,
    @required this.totalGain,
    @required this.proportionalGain,
    @required this.acceptedOptions,
    @required this.optedOptions,
    @required this.totalInvestment,
  });
}
