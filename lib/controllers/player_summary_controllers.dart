//const updatePlayerSummary = playerSummaryBase + 'updatePlayerSummary/';
//const getPlayerSummaryCa = playerSummaryBase;
//const makePlayerSummaryCa = playerSummaryBase + 'makePlayerSummary/';

import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:win75/models/PlayerSummary.dart';
import 'package:win75/utilities/end-points.dart';

final storage = SS.FlutterSecureStorage();

class PlayerSummaryControllers {
  static Future getPlayerSummary({String gameId}) async {
    PlayerSummary playerSummary;
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.get(getPlayerSummaryCa + '$gameId',
          headers: {HttpHeaders.authorizationHeader: "bearer $token"});
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        jsonResponse = jsonResponse['foundPlayerSummary'];
        playerSummary = PlayerSummary(
            gameId: jsonResponse[0]['gameId'],
            playerId: jsonResponse[0]['playerId'],
            acceptedOptions: jsonResponse[0]['acceptedOptions'],
            optedOptions: jsonResponse[0]['optedOptions'],
            profitableInvestment:
                jsonResponse[0]['profitableInvestment'].toInt(),
            totalInvestment: jsonResponse[0]['totalInvestment'].toInt(),
            proportionalGain: jsonResponse[0]['proportionalGain'].toDouble(),
            totalGain: jsonResponse[0]['totalGain'].toDouble());
        return playerSummary;
      } else {
        print("in here");
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }

  static Future makePlayerSummary({List optedOptions, String gameId}) async {
    var jsonData = json.encode({"optedOptions": optedOptions});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(makePlayerSummaryCa + gameId,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
          body: jsonData);
      print(response.body);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        if (jsonResponse['message'] == 'player created') {
          return true;
        }
      } else {
        return false;
      }
    } catch (err) {
      print(err);
      return false;
    }
  }
}
