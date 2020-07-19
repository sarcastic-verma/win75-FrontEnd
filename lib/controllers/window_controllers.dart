//const getEventWindow = windowBase;
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:win75/models/EventWindow.dart';
import 'package:win75/utilities/end-points.dart';

class WindowControllers {
  Future getEventWindowById(String eid) async {
    EventWindow window;
    try {
      var response = await http.get(getEventWindow + eid);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        jsonResponse = jsonResponse['game'];
        window = EventWindow(
            startTime: jsonResponse['startTime'],
            endTime: jsonResponse['endTime'],
            slots: jsonResponse['slots'],
            date: jsonResponse['date']);
        return window;
      } else {
        return false;
      }
    } catch (err) {
      return false;
    }
  }
}
