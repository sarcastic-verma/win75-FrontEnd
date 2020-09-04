//const getEventWindow = windowBase;
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:win75/controllers/game_controllers.dart';
import 'package:win75/models/EventWindow.dart';
import 'package:win75/utilities/end-points.dart';

class WindowControllers {
  Future getEventWindowById(String eid) async {
    EventWindow window;
    try {
      var response = await http.get(getEventWindow + eid);
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        jsonResponse = jsonResponse['eventWindow'];
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

  static Future<LinkedHashMap> getCurrentWindow() async {
    LinkedHashMap gamesId;
    try {
      String token = await storage.read(key: 'jwt');
      var response = await http.get(getCurrentEventWindow,
          headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        jsonResponse = jsonResponse['games'];
        gamesId = jsonResponse;
        return gamesId;
      } else {
        print("in else");
        return null;
      }
    } catch (err) {
      print(err);
      print("not else");
      return null;
    }
  }
}
