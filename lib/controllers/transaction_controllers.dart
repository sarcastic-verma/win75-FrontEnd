//const addMoneyCa = transactionBase + 'add';
//const redeemMoneyCa = transactionBase + 'redeem';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:win75/utilities/constants.dart';
import 'package:win75/utilities/end-points.dart';

class TransactionControllers {
  final storage = SS.FlutterSecureStorage();
  Future redeemMoney(int amount) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(redeemMoneyCa,
          headers: {
            "Content-Type": "application/json",
            "Autherization": "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['transaction']['status'] == inProgress) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
  Future addPoints(int amount) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(addPointsCa,
          headers: {
            "Content-Type": "application/json",
            "Autherization": "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['message'] == "added") {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
  Future reducePoints(int amount) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(reducePointsCa,
          headers: {
            "Content-Type": "application/json",
            "Autherization": "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['message'] == "reduced") {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
  Future addMoney(int amount) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(addMoneyCa,
          headers: {
            "Content-Type": "application/json",
            "Autherization": "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['transaction']['status'] == success) {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
