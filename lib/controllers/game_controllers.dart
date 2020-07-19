//const getGameByIdRouteCa = gameBase;
//const getGamesByUserIdRouteCa = gameBase + 'user/';
//const endGameRouteCa = gameBase + 'endgame/';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:win75/models/Game.dart';
import 'package:win75/utilities/end-points.dart';

final storage = SS.FlutterSecureStorage();

class GameControllers {
  Future getGameById(String gameId) async {
    Game game;
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.get(getGameByIdCa + gameId,
          headers: {"Autherization": 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        jsonResponse = jsonResponse['game'];
        game = Game(
            gid: jsonResponse['id'],
            betValue: jsonResponse['betValue'],
            clubTotalInvestment: jsonResponse['clubTotalInvestment'],
            spadesTotalInvestment: jsonResponse['spadesTotalInvestment'],
            diamondTotalInvestment: jsonResponse['diamondTotalInvestment'],
            heartTotalInvestment: jsonResponse['heartTotalInvestment'],
            distributableProfit: jsonResponse['distributableProfit'],
            distributableProfitPercent:
                jsonResponse['distributableProfitPercent'],
            gameInvestment: jsonResponse['gameInvestment'],
            playerCount: jsonResponse['playerCount'],
            playerSummary: jsonResponse['playerSummary'],
            totalProfit: jsonResponse['totalProfit'],
            businessProfit: jsonResponse['businessProfit'],
            droppedOptions: jsonResponse['droppedOptions'],
            slotId: jsonResponse['slotId']);
        return game;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future getGamesByUserId(String userId) async {
    List<Game> games;
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.get(getGamesByUserIdCa + userId,
          headers: {"Autherization": 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        jsonResponse = jsonResponse['games'];
        jsonResponse.forEach((item) {
          games.add(Game(
              gid: jsonResponse['id'],
              betValue: jsonResponse['betValue'],
              clubTotalInvestment: jsonResponse['clubTotalInvestment'],
              spadesTotalInvestment: jsonResponse['spadesTotalInvestment'],
              diamondTotalInvestment: jsonResponse['diamondTotalInvestment'],
              heartTotalInvestment: jsonResponse['heartTotalInvestment'],
              distributableProfit: jsonResponse['distributableProfit'],
              distributableProfitPercent:
                  jsonResponse['distributableProfitPercent'],
              gameInvestment: jsonResponse['gameInvestment'],
              playerCount: jsonResponse['playerCount'],
              playerSummary: jsonResponse['playerSummary'],
              totalProfit: jsonResponse['totalProfit'],
              businessProfit: jsonResponse['businessProfit'],
              droppedOptions: jsonResponse['droppedOptions'],
              slotId: jsonResponse['slotId']));
        });
        return games;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future endGame(String gameId) async {
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http
          .get(endGameCa + gameId, headers: {"Autherization": 'Bearer $token'});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
