import 'dart:math';

import 'package:win75/models/Game.dart';
import 'package:win75/utilities/constants.dart';

class PlaygroundGames {
  static Game get random50Game {
    int randomGame = Random().nextInt(4);
    print(randomGame);
    switch (randomGame) {
      case 0:
        return Game(
          playerCount: 5,
          betValue: 50,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 100,
          diamondTotalInvestment: 100,
          clubTotalInvestment: 50,
          heartTotalInvestment: 0,
          gameInvestment: 250,
          playerSummary: [],
        );
      case 1:
        return Game(
          playerCount: 7,
          betValue: 50,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 100,
          diamondTotalInvestment: 100,
          clubTotalInvestment: 50,
          heartTotalInvestment: 100,
          gameInvestment: 350,
          playerSummary: [],
        );

      case 2:
        return Game(
          playerCount: 4,
          betValue: 50,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 50,
          diamondTotalInvestment: 50,
          clubTotalInvestment: 0,
          heartTotalInvestment: 100,
          gameInvestment: 350,
          playerSummary: [],
        );
      case 3:
        return Game(
          playerCount: 7,
          betValue: 50,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 100,
          diamondTotalInvestment: 0,
          clubTotalInvestment: 200,
          heartTotalInvestment: 50,
          gameInvestment: 350,
          playerSummary: [],
        );

      default:
        return Game(
          playerCount: 10,
          betValue: 50,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 150,
          diamondTotalInvestment: 50,
          clubTotalInvestment: 100,
          heartTotalInvestment: 200,
          gameInvestment: 500,
          playerSummary: [],
        );
    }
  }

  static Game get random1000Game {
    int randomGame = Random().nextInt(4);
    print(randomGame);
    switch (randomGame) {
      case 0:
        return Game(
          playerCount: 7,
          betValue: 1000,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 1000,
          diamondTotalInvestment: 3000,
          clubTotalInvestment: 1000,
          heartTotalInvestment: 2000,
          gameInvestment: 7000,
          playerSummary: [],
        );
      case 1:
        return Game(
          playerCount: 4,
          betValue: 1000,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 1000,
          diamondTotalInvestment: 3000,
          clubTotalInvestment: 0,
          heartTotalInvestment: 0,
          gameInvestment: 4000,
          playerSummary: [],
        );

      case 2:
        return Game(
          playerCount: 9,
          betValue: 1000,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 2000,
          diamondTotalInvestment: 1000,
          clubTotalInvestment: 4000,
          heartTotalInvestment: 2000,
          gameInvestment: 9000,
          playerSummary: [],
        );

      case 3:
        return Game(
          playerCount: 7,
          betValue: 1000,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 3000,
          diamondTotalInvestment: 1000,
          clubTotalInvestment: 2000,
          heartTotalInvestment: 1000,
          gameInvestment: 7000,
          playerSummary: [],
        );

      default:
        return Game(
          playerCount: 8,
          betValue: 1000,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 1000,
          diamondTotalInvestment: 3000,
          clubTotalInvestment: 2000,
          heartTotalInvestment: 2000,
          gameInvestment: 8000,
          playerSummary: [],
        );
    }
  }

  static Game get random500Game {
    int randomGame = Random().nextInt(4);
    print(randomGame);
    switch (randomGame) {
      case 0:
        return Game(
          playerCount: 7,
          betValue: 500,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 0,
          diamondTotalInvestment: 2000,
          clubTotalInvestment: 1000,
          heartTotalInvestment: 500,
          gameInvestment: 3500,
          playerSummary: [],
        );
      case 1:
        return Game(
          playerCount: 10,
          betValue: 500,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 2000,
          diamondTotalInvestment: 1500,
          clubTotalInvestment: 1000,
          heartTotalInvestment: 500,
          gameInvestment: 5000,
          playerSummary: [],
        );

      case 2:
        return Game(
          playerCount: 9,
          betValue: 500,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 1000,
          diamondTotalInvestment: 1000,
          clubTotalInvestment: 2000,
          heartTotalInvestment: 500,
          gameInvestment: 4500,
          playerSummary: [],
        );

      case 3:
        return Game(
          playerCount: 4,
          betValue: 500,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 500,
          diamondTotalInvestment: 1000,
          clubTotalInvestment: 0,
          heartTotalInvestment: 500,
          gameInvestment: 2000,
          playerSummary: [],
        );

      default:
        return Game(
          playerCount: 7,
          betValue: 500,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 0,
          diamondTotalInvestment: 1000,
          clubTotalInvestment: 2000,
          heartTotalInvestment: 500,
          gameInvestment: 3500,
          playerSummary: [],
        );
    }
  }

  static Game get random100Game {
    int randomGame = Random().nextInt(4);
    print(randomGame);
    switch (randomGame) {
      case 0:
        return Game(
          playerCount: 7,
          betValue: 100,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 100,
          diamondTotalInvestment: 200,
          clubTotalInvestment: 100,
          heartTotalInvestment: 300,
          gameInvestment: 700,
          playerSummary: [],
        );
      case 1:
        return Game(
          playerCount: 4,
          betValue: 100,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 100,
          diamondTotalInvestment: 200,
          clubTotalInvestment: 0,
          heartTotalInvestment: 100,
          gameInvestment: 400,
          playerSummary: [],
        );

      case 2:
        return Game(
          playerCount: 5,
          betValue: 100,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 0,
          diamondTotalInvestment: 100,
          clubTotalInvestment: 100,
          heartTotalInvestment: 300,
          gameInvestment: 500,
          playerSummary: [],
        );

      case 3:
        return Game(
          playerCount: 7,
          betValue: 100,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 200,
          diamondTotalInvestment: 100,
          clubTotalInvestment: 300,
          heartTotalInvestment: 100,
          gameInvestment: 700,
          playerSummary: [],
        );

      default:
        return Game(
          playerCount: 10,
          betValue: 100,
          gid: "random",
          slotId: "alsoRandom",
          spadesTotalInvestment: 200,
          diamondTotalInvestment: 200,
          clubTotalInvestment: 300,
          heartTotalInvestment: 300,
          gameInvestment: 1000,
          playerSummary: [],
        );
    }
  }

  static List calcSlotResult(
      {int spadesTotalInvestment,
      int clubTotalInvestment,
      int diamondTotalInvestment,
      int heartTotalInvestment,
      int gameInvestment,
      int playerCount}) {
    print(
        '$playerCount is pc\n$clubTotalInvestment is cti\n$gameInvestment is gi\n$heartTotalInvestment is hti\n$diamondTotalInvestment is dti\n$spadesTotalInvestment is sti');
    double businessProfit,
        totalProfit,
        distributableProfit,
        distributableProfitPercent;
    List droppedOptions;
    int maxInvestment = [
      heartTotalInvestment,
      spadesTotalInvestment,
      clubTotalInvestment,
      diamondTotalInvestment
    ].reduce(max);
    List maxInvestmentArray = [];
    if (clubTotalInvestment == maxInvestment) {
      maxInvestmentArray.add({"investment": clubTotalInvestment, "name": club});
    }
    if (diamondTotalInvestment == maxInvestment) {
      maxInvestmentArray
          .add({"investment": diamondTotalInvestment, "name": diamond});
    }
    if (spadesTotalInvestment == maxInvestment) {
      maxInvestmentArray
          .add({"investment": spadesTotalInvestment, "name": spades});
    }
    if (heartTotalInvestment == maxInvestment) {
      maxInvestmentArray
          .add({"investment": heartTotalInvestment, "name": heart});
    }
    //////////Case all equal/////////////
    if (maxInvestmentArray.length == 4 || playerCount <= 2) {
      businessProfit = 0;
      droppedOptions = [spades, heart, diamond, club];
      totalProfit = 0;
      distributableProfit = 0;
      distributableProfitPercent = 0;
      return [
        businessProfit,
        droppedOptions,
        totalProfit,
        distributableProfit,
        distributableProfitPercent
      ];
    }
    /////////////////Case 3 equal///////////////
    else if (maxInvestmentArray.length == 3) {
      maxInvestment = maxInvestment * 3;
      businessProfit = (maxInvestment * maxInvestment) / gameInvestment;
      List<Map> acceptedOptions = [
        {"name": club, "investment": clubTotalInvestment},
        {"name": heart, "investment": heartTotalInvestment},
        {"name": spades, "investment": spadesTotalInvestment},
        {"name": diamond, "investment": diamondTotalInvestment}
      ];
      droppedOptions = [];
      totalProfit = 0;
      for (int i = 0; i < maxInvestmentArray.length; i++) {
        acceptedOptions = acceptedOptions
            .where((item) => item != maxInvestmentArray[i])
            .toList();
        droppedOptions.add(maxInvestmentArray[i]['name']);
        totalProfit += maxInvestmentArray[i]['investment'];
      }
      bool specialCondition = false;
      acceptedOptions.forEach(
          (element) => {specialCondition = element["investment"] == 0});
      if (specialCondition) {
        Random().nextDouble() >= 0.5
            ? droppedOptions.removeLast()
            : droppedOptions.removeAt(0);
        businessProfit = businessProfit / 3;
        distributableProfit = totalProfit - businessProfit;
        distributableProfitPercent = 33.0;
      } else {
        distributableProfit = totalProfit - businessProfit;
        distributableProfitPercent = (maxInvestment * 100) / gameInvestment;
      }
      return [
        businessProfit,
        droppedOptions,
        totalProfit,
        distributableProfit,
        distributableProfitPercent
      ];
    }
    ////////////////Case 2 equal////////////////
    else if (maxInvestmentArray.length == 2) {
      maxInvestment = maxInvestment * 2;
      businessProfit = (maxInvestment * maxInvestment) / gameInvestment;
      droppedOptions = [];
      List<Map> acceptedOptions = [
        {"investment": clubTotalInvestment, "name": club},
        {"investment": heartTotalInvestment, "name": heart},
        {"investment": spadesTotalInvestment, "name": spades},
        {"investment": diamondTotalInvestment, "name": diamond}
      ];
      totalProfit = 0;
      for (int i = 0; i < maxInvestmentArray.length; i++) {
        acceptedOptions = acceptedOptions
            .where((item) => item["name"] != maxInvestmentArray[i]['name'])
            .toList();
        droppedOptions.add(maxInvestmentArray[i]['name']);
        totalProfit += maxInvestmentArray[i]['investment'];
      }
      // console.log(acceptedOptions);
      bool specialCondition = false;
      acceptedOptions.forEach(
          (element) => {specialCondition = element['investment'] == 0});
      // console.log(specialCondition);
      if (specialCondition) {
        Random().nextDouble() >= 0.5
            ? droppedOptions.removeLast()
            : droppedOptions.removeAt(0);
        businessProfit = businessProfit / 2;
        distributableProfit = totalProfit - businessProfit;
        distributableProfitPercent = 50.0;
      } else {
        distributableProfit = totalProfit - businessProfit;
        distributableProfitPercent = (maxInvestment * 100) / gameInvestment;
      }
      return [
        businessProfit,
        droppedOptions,
        totalProfit,
        distributableProfit,
        distributableProfitPercent
      ];
    }
    ////////////////case 1 max//////////////////
    else if (maxInvestmentArray.length == 1) {
      businessProfit = maxInvestment * maxInvestment / gameInvestment;
      droppedOptions = [];
      totalProfit = 0;
      for (int i = 0; i < maxInvestmentArray.length; i++) {
        droppedOptions.add(maxInvestmentArray[i]['name']);
        totalProfit += maxInvestmentArray[i]['investment'];
      }
      distributableProfit = totalProfit - businessProfit;
      distributableProfitPercent = (maxInvestment * 100) / gameInvestment;
      return [
        businessProfit,
        droppedOptions,
        totalProfit,
        distributableProfit,
        distributableProfitPercent
      ];
    }
    return [];
  }
}
