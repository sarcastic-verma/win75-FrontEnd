import 'package:flutter/cupertino.dart';

class EventWindow {
  String date;
  String startTime;
  String endTime;
  List slots;
  EventWindow({
    @required this.endTime,
    @required this.startTime,
    @required this.slots,
    @required this.date,
  });
}
