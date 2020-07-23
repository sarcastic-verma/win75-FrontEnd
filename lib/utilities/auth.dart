import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:win75/models/User.dart';

class AuthService {
  Future storeUserInSharedPreferences({User user}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> games = user.games.cast<String>();
    List<String> transactions = user.transactions.cast<String>();
    await prefs.setBool('disabled', user.disabled);
    await prefs.setString('uid', user.uid);
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('image', user.image);
    await prefs.setInt('inWalletCash', user.inWalletCash);
    await prefs.setString('joinedOn', user.joinedOn);
    await prefs.setString('mobile', user.mobile);
    await prefs.setInt('points', user.points);
    await prefs.setStringList('games', games);
    await prefs.setStringList('transactions', transactions);
    await prefs.setInt('totalAmountWon', user.totalAmountWon);
    await prefs.setInt('totalAmountSpent', user.totalAmountSpent);
    await prefs.setString('referralCode', user.referralCode);
  }

  //fetch the user details from shared preferences
  Future<User> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      referralCode: prefs.getString('referralCode'),
      totalAmountWon: prefs.getInt('totalAmountWon'),
      totalAmountSpent: prefs.getInt('totalAmountSpent'),
      disabled: prefs.getBool('disabled'),
      games: prefs.getStringList('games'),
      transactions: prefs.getStringList('transactions'),
      points: prefs.getInt('points'),
      joinedOn: prefs.getString("joinedOn"),
      username: prefs.getString('username'),
      image: prefs.getString('image'),
      inWalletCash: prefs.getInt('inWalletCash'),
      mobile: prefs.getString('mobile'),
      uid: prefs.getString('uid'),
      email: prefs.getString('email'),
    );
  }

  final storage = FlutterSecureStorage();
  Future logOutUser() async {
    try {
      await storage.delete(key: "jwt");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('uid');
      await prefs.remove('username');
      await prefs.remove('email');
      await prefs.remove('points');
      await prefs.remove('games');
      await prefs.remove('transactions');
      await prefs.remove('referralCode');
      await prefs.remove('totalAmountWon');
      await prefs.remove('totalAmountSpent');
      await prefs.remove('inWalletCash');
      await prefs.remove('image');
      await prefs.remove('uid');
      await prefs.remove('mobile');
      await prefs.remove('joinedOn');
    } catch (err) {
      print(err);
    }
  }

  Future updateUsernameImage({
    username,
    mobile,
    password,
    imgUrl,
  }) async {
    try {} catch (e) {
      print("caught error: ${e.toString()}");
    }
  }
}
