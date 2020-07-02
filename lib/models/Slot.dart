import 'package:flutter/cupertino.dart';

import 'Game.dart';

class Slot {
  String eventWindowId;
  String startTime;
  String endTime;
  List<Game> games;
  Slot({
    @required this.eventWindowId,
    @required this.games,
    @required this.endTime,
    @required this.startTime,
  });
}
