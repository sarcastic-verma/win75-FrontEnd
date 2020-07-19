//const updatePlayerSummary = playerSummaryBase + 'updatePlayerSummary/';
//const getPlayerSummaryCa = playerSummaryBase;
//const makePlayerSummaryCa = playerSummaryBase + 'makePlayerSummary/';

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:win75/models/PlayerSummary.dart';
import 'package:win75/utilities/end-points.dart';

final storage = SS.FlutterSecureStorage();

class PlayerSummaryControllers {
  Future getPlayerSummary(String summaryId) async {
    PlayerSummary playerSummary;
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http
          .get(getPlayerSummaryCa, headers: {"Autherization": "bearer $token"});
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        jsonResponse = jsonResponse['foundPlayerSummary'];
        playerSummary = PlayerSummary(
            gameId: jsonResponse['gameId'],
            playerId: jsonResponse['playerId'],
            acceptedOptions: jsonResponse['acceptedOptions'],
            optedOptions: jsonResponse['optedOptions'],
            profitableInvestment: jsonResponse['profitableInvestment'],
            totalInvestment: jsonResponse['totalInvestment'],
            proportionalGain: jsonResponse['proportionalGain'],
            totalGain: jsonResponse['totalGain']);
        return playerSummary;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }

  Future makePlayerSummary(List optedOptions) async {
    var jsonData = json.encode({"optedOptions": optedOptions});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.patch(makePlayerSummaryCa,
          headers: {
            "Content-Type": "application/json",
            "Autherization": 'Bearer $token'
          },
          body: jsonData);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['message'] == 'player created') {
          return true;
        }
      } else {
        print(response);
      }
    } catch (err) {
      return false;
    }
  }
}
