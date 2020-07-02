import 'package:flutter/material.dart';
import 'package:win75/components/CustomOption.dart';

class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /////////////get////////////////
//                    var response = await http
//                        .get(getUserById + '5ec61cd1cb98ef2b7a7ba77a');
//                    if (response.statusCode == 200) {
//                      var jsonResponse = jsonDecode(response.body);
//                      String userDP = jsonResponse["user"]['image'];
//                      print(userDP);
//                      setState(() {
//                        imageURL = userDP.replaceAll("localhost", "10.0.2.2");
//                        showImage = true;
//                      });
//                    } else {
//                      print(response.statusCode);
//                    }
          /////////////post///////////
//                    var jsonData = json.encode(
//                        {"password": "abcdpart3", "email": "shivam@gmail.com"});
//                    var response = await http.post(login,
//                        headers: {"Content-Type": "application/json"},
//                        body: jsonData);
//                    print(response.body);
          ///////////////////patch//////////////////
//                    var response = await http.patch(
//                      likeStory + "5ec43a4b9bfb033d60fb1af7",
//                      headers: {
//                        "Content-Type": "application/json",
//                        'Authorization':
//                            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWMzYTgwYjYzMTJiZDZiYWFiMjQ5YmQiLCJlbWFpbCI6InNoaXZhbXZlcm1hQGdtYWlsLmNvbSIsImlhdCI6MTU4OTg4MTAzM30.qNAMDgCb_0TwYuWyzo9_22E36sttxlm4d2CCZxEOS2I'
//                      },
//                    );
//                    print(response.body);
          /////////////////delete////////////////////
//                    var response = await http.delete(
//                        deleteStory + "5ec43a4b9bfb033d60fb1af7",
//                        headers: {
//                          'Authorization':
//                              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWMzYTgwYjYzMTJiZDZiYWFiMjQ5YmQiLCJlbWFpbCI6InNoaXZhbXZlcm1hQGdtYWlsLmNvbSIsImlhdCI6MTU4OTg4MTAzM30.qNAMDgCb_0TwYuWyzo9_22E36sttxlm4d2CCZxEOS2I'
//                        });
//                    print(response.body);
          ///////////send image/////////////
//                      Dio dio = Dio();
//                      var _image;
//                      File image = await ImagePicker.pickImage(
//                          source: ImageSource.gallery);
//                      _image = image;
//                      if (_image != null) {
//                        FormData formData = new FormData.fromMap({
//                          "username": "blah",
//                          "email": "shivam@opi.com",
//                          "password": "abcdpart3",
//                          "image": await MultipartFile.fromFile(
//                            _image.path,
//                            filename: _image.path.split('/').last,
//                            contentType: MediaType('image', 'jpg'),
//                          ),
//                        });
//                        print(_image.path);
//                        try {
//                          var response = await dio.post(
//                            signup,
//                            data: formData,
//                          );
//                          print(response.data);
//                        } on DioError catch (error) {
//                          print(error.response);
//                        }
//                      } else {
//                        FormData formData = new FormData.fromMap({
//                          "username": "blah",
//                          "email": "shivam@opi.com",
//                          "password": "abcdpart3",
//                        });
//                        try {
//                          var response = await dio.post(
//                            signup,
//                            data: formData,
//                          );
//                          print(response.data);
//                        } on DioError catch (error) {
//                          print(error.response);
//                        }
//                      }
//                    highlightColor: kPrimaryColor,
//                    splashColor: kPrimaryColor,
//                    color: kAccentColor,
          CustomOption(
            optionName: "Spade",
          ),
          CustomOption(
            optionName: "Diamond",
          ),
          CustomOption(
            optionName: "Heart",
          ),
          CustomOption(
            optionName: "Club",
          ),
        ],
      ),
    );
  }
}

//Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: [
//RaisedButton(
//onPressed: () {
//print("bet removed");
//},
//child: Text("-"),
//),
//Text("spade"),
//RaisedButton(
//onPressed: () {
//print("bet placed");
//},
//child: Text("+"),
//)
//],
//);
