//const addMoneyCa = transactionBase + 'add';
//const redeemMoneyCa = transactionBase + 'redeem';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:win75/models/Transaction.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/constants.dart';
import 'package:win75/utilities/end-points.dart';

final storage = SS.FlutterSecureStorage();

class TransactionControllers {
  static Future<List> redeemMoney({int amount}) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(redeemMoneyCa,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['transaction']['status'] == inProgress) {
        User user;
        jsonResponse = jsonResponse['user'];
        user = User(
          uid: jsonResponse['_id'],
          referralCode: jsonResponse['referralCode'],
          points: jsonResponse['points'],
          mobile: jsonResponse['mobile'],
          totalAmountSpent: jsonResponse['totalAmountSpent'],
          totalAmountWon: jsonResponse['totalAmountWon'],
          inWalletCash: jsonResponse['inWalletCash'],
          username: jsonResponse['username'],
          email: jsonResponse['email'],
          joinedOn: jsonResponse['joinedOn'],
          image: jsonResponse['image'],
          transactions: jsonResponse['transactions'],
          games: jsonResponse['games'],
          disabled: jsonResponse['disabled'],
        );
        return [true, user];
      } else {
        return [false];
      }
    } catch (err) {
      return [false];
    }
  }

  static Future<List<Transaction>> getTransactions() async {
    List<Transaction> transactions = [];
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.get(getTransactionByUserIdCa,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        jsonResponse = jsonResponse['transactions'];
        jsonResponse.forEach((item) {
          transactions.add(Transaction(
              userId: item['userId'],
              amount: item['amount'],
              status: item['status'],
              type: item['type'],
              transactionId: item['transactionId']));
        });
      } else {
        print(response.statusCode);
        print(response.body);
        print("in else");
      }
    } catch (err) {
      print(err);
      print("in catch");
    }
    transactions = transactions.reversed.toList();
    return transactions;
  }

  static Future<List> addPoints({int amount}) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(addPointsCa,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['message'] == "added") {
        User user;
        jsonResponse = jsonResponse['user'];
        user = User(
          uid: jsonResponse['_id'],
          referralCode: jsonResponse['referralCode'],
          points: jsonResponse['points'],
          mobile: jsonResponse['mobile'],
          totalAmountSpent: jsonResponse['totalAmountSpent'],
          totalAmountWon: jsonResponse['totalAmountWon'],
          inWalletCash: jsonResponse['inWalletCash'],
          username: jsonResponse['username'],
          email: jsonResponse['email'],
          joinedOn: jsonResponse['joinedOn'],
          image: jsonResponse['image'],
          transactions: jsonResponse['transactions'],
          games: jsonResponse['games'],
          disabled: jsonResponse['disabled'],
        );
        return [true, user];
      } else {
        return [false];
      }
    } catch (err) {
      return [false];
    }
  }

  static Future realTransactionCa({int amount, String nonce}) async {
    var jsonData = json.encode({"amount": amount, "nonce": nonce});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(realTransaction, body: jsonData, headers: {
        "Content-Type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      print(response.body);
      return response;
    } catch (err) {
      print("yha");
      print(err);
      return null;
    }
  }

  static Future<List> reducePoints({int amount}) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(reducePointsCa,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['message'] == "reduced") {
        User user;
        jsonResponse = jsonResponse['user'];
        user = User(
          uid: jsonResponse['_id'],
          referralCode: jsonResponse['referralCode'],
          points: jsonResponse['points'],
          mobile: jsonResponse['mobile'],
          totalAmountSpent: jsonResponse['totalAmountSpent'],
          totalAmountWon: jsonResponse['totalAmountWon'],
          inWalletCash: jsonResponse['inWalletCash'],
          username: jsonResponse['username'],
          email: jsonResponse['email'],
          joinedOn: jsonResponse['joinedOn'],
          image: jsonResponse['image'],
          transactions: jsonResponse['transactions'],
          games: jsonResponse['games'],
          disabled: jsonResponse['disabled'],
        );
        return [true, user];
      } else {
        return [false];
      }
    } catch (err) {
      return [false];
    }
  }

  static Future<List> addMoney({int amount}) async {
    var jsonData = json.encode({"amount": amount});
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.post(addMoneyCa,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: "Bearer $token"
          },
          body: jsonData);
      var jsonResponse = await json.decode(response.body);
      if (jsonResponse['transaction']['status'] == success) {
        User user;
        jsonResponse = jsonResponse['user'];
        user = User(
          uid: jsonResponse['_id'],
          referralCode: jsonResponse['referralCode'],
          points: jsonResponse['points'],
          mobile: jsonResponse['mobile'],
          totalAmountSpent: jsonResponse['totalAmountSpent'],
          totalAmountWon: jsonResponse['totalAmountWon'],
          inWalletCash: jsonResponse['inWalletCash'],
          username: jsonResponse['username'],
          email: jsonResponse['email'],
          joinedOn: jsonResponse['joinedOn'],
          image: jsonResponse['image'],
          transactions: jsonResponse['transactions'],
          games: jsonResponse['games'],
          disabled: jsonResponse['disabled'],
        );
        return [true, user];
      } else {
        print(jsonResponse);
        print("in else");
        return [false];
      }
    } catch (err) {
      print(err);
      print("in catch");
      return [false];
    }
  }
}
