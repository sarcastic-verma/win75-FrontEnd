import 'package:flutter/cupertino.dart';

import 'Slot.dart';

class EventWindow {
  String date;
  String startTime;
  String endTime;
  List<Slot> slots;
  EventWindow({
    @required this.endTime,
    @required this.startTime,
    @required this.slots,
    @required this.date,
  });
}
