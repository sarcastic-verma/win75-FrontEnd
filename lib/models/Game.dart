import 'package:flutter/cupertino.dart';

class Game {
  String gid;
  String slotId;
  double distributableProfitPercent;
  int businessProfit;
  int distributableProfit;
  int totalProfit;
  int gameInvestment;
  int playerCount;
  List droppedOptions;
  int spadesTotalInvestment;
  int heartTotalInvestment;
  int diamondTotalInvestment;
  int clubTotalInvestment;
  int betValue;
  List playerSummary;
  Game({
    @required this.slotId,
    @required this.betValue,
    @required this.distributableProfit,
    @required this.totalProfit,
    @required this.gameInvestment,
    @required this.droppedOptions,
    @required this.spadesTotalInvestment,
    @required this.clubTotalInvestment,
    @required this.heartTotalInvestment,
    @required this.diamondTotalInvestment,
    @required this.gid,
    @required this.distributableProfitPercent,
    @required this.businessProfit,
    @required this.playerCount,
    @required this.playerSummary,
  });
}
