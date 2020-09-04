import 'package:flutter/cupertino.dart';

class GamesProvider extends ChangeNotifier {
//  DateTime gameDate;
  String played4to5;
  String played5to6;
  String played3to4;
  GamesProvider({
    @required this.played3to4,
    @required this.played4to5,
    @required this.played5to6,
  });

  void removeSlots() {
    this.played5to6 = "";
    this.played4to5 = "";
    this.played3to4 = "";
    notifyListeners();
  }

  void updateSlots({String played3to4, String played4to5, String played5to6}) {
    this.played5to6 = played5to6;
    this.played4to5 = played4to5;
    this.played3to4 = played3to4;
    notifyListeners();
  }
}
