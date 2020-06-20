import 'package:shared_preferences/shared_preferences.dart';
import 'package:win75/models/User.dart';

class AuthService {
  Future storeUserInSharedPreferences(
      {String uid,
      String phoneNumber,
      String username,
      String email,
      String image,
      String date}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('uid', uid);
    await prefs.setString('phoneNumber', phoneNumber);

    await prefs.setString('username', username);
    await prefs.setString('email', email);
    await prefs.setString('image', image);
    await prefs.setString('dateOfCreation', date);

    print('saved successfully');
    print(prefs.getString('phoneNumber'));
  }

  //fetch the user details from shared preferences
  Future<User> getUserFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      uid: prefs.getString('uid'),
      phoneNumber: prefs.getString('phoneNumber'),
      username: prefs.getString('username'),
      image: prefs.getString('image'),
      date: prefs.getString('date'),
      email: prefs.getString('email'),
    );
  }

  Future logOutUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('uid');
      await prefs.remove('phoneNumber');
      await prefs.remove('username');
      await prefs.remove('email');
      await prefs.remove('image');
      await prefs.remove('dateOfCreation');
    } catch (err) {
      print(err);
    }
  }

  Future updateUsernameImage(name, url, uid) async {
    try {
//      print("updateObtained_ $url");
//      var databaseReference = Firestore.instance;
//      await databaseReference
//          .collection('users')
//          .document(uid)
//          .updateData({'username': name, 'image': url});
//      final QuerySnapshot result = await Firestore.instance
//          .collection('users')
//          .where('uid', isEqualTo: uid)
//          .getDocuments();
//      final List<DocumentSnapshot> documents = result.documents;
//      print("db_${documents[0]['username']}");
//      // .updateData({'username': name});
//      // String s = 'yes';
//      // return s;
    } catch (e) {
      print("caught error: ${e.toString()}");
    }
  }
}
