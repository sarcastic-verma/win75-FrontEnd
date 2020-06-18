import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:win75/components/DrawerBoilerPlate.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  void toggle() {
    _innerDrawerKey.currentState.toggle(direction: InnerDrawerDirection.start);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDrawer(
      innerDrawerKey: _innerDrawerKey,
      scaffold: Scaffold(
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
//                      splashColor: kPrimaryColor,
                    icon: Icon(
                      Icons.menu,
                    ),
                    onPressed: () async {
                      toggle();
                    },
                    iconSize: 30,
//                      highlightColor: kPrimaryColor,
//                      color: kAccentColor,
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.search),
                    onPressed: () async {
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
                    },
                    iconSize: 25,
                    tooltip: "Search Story",
//                    highlightColor: kPrimaryColor,
//                    splashColor: kPrimaryColor,
//                    color: kAccentColor,
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "#featured",
                  textAlign: TextAlign.end,
//                  style: kTextHeaderStyle.copyWith(
//                      fontSize: MediaQuery.of(context).size.width * 0.1),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )),
      ),
    );
  }
}