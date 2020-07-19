import 'package:shared_preferences/shared_preferences.dart';
import 'package:win75/models/User.dart';

class AuthService {
  Future storeUserInSharedPreferences(
      {int inWalletCash,
      String uid,
      String mobile,
      String username,
      String email,
      String image,
      bool disabled,
      String joinedOn,
      int points}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('disabled', disabled);
    await prefs.setString('uid', uid);
    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('image', image);
    await prefs.setInt('inWalletCash', inWalletCash);
    await prefs.setString('joinedOn', joinedOn);
    await prefs.setString('mobile', mobile);
    await prefs.setInt('points', points);
  }

  //fetch the user details from shared preferences
  Future<User> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      disabled: prefs.getBool('disabled'),
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

  Future logOutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('uid');
      await prefs.remove('username');
      await prefs.remove('email');
      await prefs.remove('points');
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
