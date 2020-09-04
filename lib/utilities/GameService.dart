import 'package:shared_preferences/shared_preferences.dart';
import 'package:win75/models/GamesProvider.dart';

class GameService {
  static Future storeGameInSharedPreferences(
      {GamesProvider gamesProvider}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('played3to4', gamesProvider.played3to4);
    await prefs.setString('played4to5', gamesProvider.played4to5);
    await prefs.setString('played5to6', gamesProvider.played5to6);
  }

  //fetch the gamesProvider details from shared preferences
  static Future removeGameSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('played3to4');
    await prefs.remove('played4to5');
    await prefs.remove('played5to6');
  }

  static Future<GamesProvider> getGameFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return GamesProvider(
      played3to4: prefs.getString('played3to4'),
      played4to5: prefs.getString('played4to5'),
      played5to6: prefs.getString('played5to6'),
    );
  }
}
