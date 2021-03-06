import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as SS;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/end-points.dart';

final storage = SS.FlutterSecureStorage();

class UserController {
  static Future<String> changeUserPassword(
      {String currentPassword, String newPassword}) async {
    String message;
    var jsonData = json.encode(
        {"newPassword": newPassword, "currentPassword": currentPassword});
    try {
      String token = await storage.read(key: 'jwt');
      print(token);
      var response = await http.patch(changePassword,
          headers: {
            "Content-Type": "application/json",
            HttpHeaders.authorizationHeader: 'Bearer $token'
          },
          body: jsonData);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        message = jsonResponse['message'];
      } else {
        print(response.body);
        print("in else");
        message = response.body.substring(12, response.body.length - 2);
      }
    } catch (err) {
      message = "nani";
    }
    return message;
  }

  static Future<List<dynamic>> editUser(
      {File image, String mobile, String email, String username}) async {
    User user;
    Dio dio = Dio();
    File _image = image;
    if (_image != null) {
      FormData formData = new FormData.fromMap({
        "username": username,
        "email": email,
        "mobile": mobile,
        "image": await MultipartFile.fromFile(
          _image.path,
          filename: _image.path.split('/').last,
          contentType: MediaType('image', 'jpg'),
        ),
      });
      try {
        String token = await storage.read(key: "jwt");
        var response = await dio.patch(editUserCa,
            data: formData,
            options: Options(
              headers: {"Autherization": "Bearer $token"},
            ));
        var jsonResponse = await json.decode(response.data);
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
      } on DioError catch (error) {
        print(error.response);
      }
    } else {
      FormData formData = new FormData.fromMap(
          {"username": username, "email": email, "mobile": mobile});
      try {
        String token = await storage.read(key: "jwt");
        var response = await dio.patch(editUserCa,
            data: formData,
            options: Options(
              headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
            ));
        var jsonResponse = await response.data;
        print(response.data);
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
      } on DioError catch (error) {
        print(error.response.data['message']);
        return [error.response.data['message']];
      }
    }
    return ["success", user];
  }

  static Future<List<User>> fetchLeaderBoard() async {
    List<User> users = [];
    try {
      var response = await http.get(getLeaderBoard);
      if (response.statusCode == 200) {
        var jsonResponse = await json.decode(response.body);
        jsonResponse = jsonResponse['users'];
        jsonResponse.forEach((item) {
          users.add(User(
            uid: item['_id'],
            referralCode: item['referralCode'],
            points: item['points'],
            mobile: item['mobile'],
            totalAmountSpent: item['totalAmountSpent'],
            totalAmountWon: item['totalAmountWon'],
            inWalletCash: item['inWalletCash'],
            username: item['username'],
            email: item['email'],
            joinedOn: item['joinedOn'],
            image: item['image'],
            transactions: item['transactions'],
            games: item['games'],
            disabled: item['disabled'],
          ));
        });
      } else {
        print(response.statusCode);
        print("in else");
      }
    } catch (err) {
      print(err);
      print("in catch");
    }
    return users;
  }

  static Future<bool> forgotPasswordController({String email}) async {
    String message;
    try {
      var response = await http.get(forgotPassword + email,
          headers: {"Content-Type": "application/json"});
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        message = jsonResponse['message'];
      } else {
        print(response.body);
      }
    } catch (err) {
      print(err);
    }
    return message == "Password updated";
  }

  static Future<List<dynamic>> userLogin(
      {String email, String password}) async {
    var jsonData = json.encode({"password": password, "email": email});
    String token;
    User user;
    try {
      var response = await http.post(logIn,
          headers: {"Content-Type": "application/json"}, body: jsonData);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        token = jsonResponse["token"];
        jsonResponse = jsonResponse["user"];
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
      } else {
        print(response.statusCode);
        if (response.statusCode == 403) {
          return [response.body.substring(12, response.body.length - 2)];
        }
      }
    } catch (e) {
      print(e);
    }
    return [token, user];
  }

  static Future<List<dynamic>> imageUserSignUp(
      {File image,
      String mobile,
      String email,
      String referralCode,
      String password,
      String username}) async {
    String token;
    User user;
    Dio dio = Dio();
    File _image = image;
    if (_image != null) {
      FormData formData = new FormData.fromMap({
        "username": username,
        "email": email,
        "referralCode": referralCode ?? null,
        "mobile": mobile,
        "password": password,
        "image": await MultipartFile.fromFile(
          _image.path,
          filename: _image.path.split('/').last,
          contentType: MediaType('image', 'jpg'),
        ),
      });
      try {
        var response = await dio.post(
          signUp,
          data: formData,
        );
        print("lol");
        token = response.data['token'];
        var jsonResponse = response.data;
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
      } on DioError catch (error) {
        print(error.response);
        if (error.error == 'Http status error [422]')
          return [error.response.data['message']];
      }
    } else {
      FormData formData = new FormData.fromMap({
        "username": username,
        "email": email,
        "password": password,
        "referralCode": referralCode ?? null,
        "mobile": mobile
      });
      try {
        var response = await dio.post(
          signUp,
          data: formData,
        );
        print(response.statusCode);
        var jsonResponse = response.data;
        jsonResponse = jsonResponse['user'];
        token = response.data['token'];
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
      } on DioError catch (error) {
        print("in else");
        print(error.error);
        if (error.error == 'Http status error [422]')
          return [error.response.data['message']];
      }
    }
    return [token, user];
  }

//  static Future<List<dynamic>> userSignUp(
//      {String mobile, String email, String password, String username}) async {
//    var jsonData = json.encode({
//      "password": password,
//      "mobile": mobile,
//      "email": email,
//      "username": username
//    });
//    String token;
//    User user;
//    try {
//      var response = await http.post(signUp,
//          headers: {"Content-Type": "application/json"}, body: jsonData);
//      if (response.statusCode == 200) {
//        var jsonResponse = await jsonDecode(response.body);
//        token = jsonResponse["token"];
//        jsonResponse = jsonResponse["user"];
//        user = User(
//          uid: jsonResponse['_id'],
//          referralCode: jsonResponse['referralCode'],
//          points: jsonResponse['points'],
//          mobile: jsonResponse['mobile'],
//          totalAmountSpent: jsonResponse['totalAmountSpent'],
//          totalAmountWon: jsonResponse['totalAmountWon'],
//          inWalletCash: jsonResponse['inWalletCash'],
//          username: jsonResponse['username'],
//          email: jsonResponse['email'],
//          joinedOn: jsonResponse['joinedOn'],
//          image: jsonResponse['image'],
//          transactions: jsonResponse['transactions'],
//          games: jsonResponse['games'],
//          disabled: jsonResponse['disabled'],
//        );
//      } else {
//        print(response.statusCode);
//      }
//    } catch (e) {
//      print(e);
//    }
//    return [token, user];
//  }

  static Future<List<User>> getEveryUsers() async {
    List<User> users = [];
    try {
      var response = await http.get(getUsers);
      if (response.statusCode == 200) {
        var jsonResponse = await jsonDecode(response.body);
        jsonResponse = jsonResponse['users'];
        jsonResponse.forEach((item) {
          users.add(User(
            uid: item['_id'],
            referralCode: item['referralCode'],
            points: item['points'],
            mobile: item['mobile'],
            totalAmountSpent: item['totalAmountSpent'],
            totalAmountWon: item['totalAmountWon'],
            inWalletCash: item['inWalletCash'],
            username: item['username'],
            email: item['email'],
            joinedOn: item['joinedOn'],
            image: item['image'],
            transactions: item['transactions'],
            games: item['games'],
            disabled: item['disabled'],
          ));
        });
      } else {
        print(response.statusCode);
      }
    } catch (err) {
      print(err);
    }
    return users;
  }

  static Future<User> getUser({String uid}) async {
    User user;
    try {
      var response = await http.get(getUserById + uid);
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
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
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}
