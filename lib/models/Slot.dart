import 'package:flutter/cupertino.dart';

import 'Game.dart';

class Slot {
  String startTime;
  String endTime;
  List<Game> games;
  Slot({
    @required this.games,
    @required this.endTime,
    @required this.startTime,
  });
}
