import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/AccountSettings.dart';
import 'package:win75/screens/battlefield.dart';
import 'package:win75/screens/leaderboard.dart';
import 'package:win75/screens/playground.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';

// ignore: must_be_immutable
class Pages extends StatefulWidget {
  static const id = '/pages';

  int currentTab = 1;
  int selectedTab = 1;
  String currentTitle = 'BattleField';
  Widget currentPage = BattleFieldScreen();

  Pages({
    Key key,
    this.currentTab,
  });

  @override
  _PagesState createState() {
    return _PagesState();
  }
}

class _PagesState extends State<Pages> {
  final AuthService authService = AuthService();
  @override
  initState() {
    _selectTab(widget.currentTab);
    super.initState();
  }

  DateTime backButtonPressedTime;

  @override
  void didUpdateWidget(Pages oldWidget) {
    _selectTab(oldWidget.currentTab);
    super.didUpdateWidget(oldWidget);
  }

  Future<bool> onWillPopHome() async {
    DateTime currentTime = DateTime.now();
    //Statement 1 Or statement2
    bool backButton = backButtonPressedTime == null ||
        currentTime.difference(backButtonPressedTime) > Duration(seconds: 3);
    if (backButton) {
      backButtonPressedTime = currentTime;
      Fluttertoast.showToast(
          msg: "Press back again to exit",
          backgroundColor: Colors.black,
          textColor: Colors.white);
      return false;
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return true;
  }

  Future<bool> onWillPop() async {
    _selectTab(1);
    return false;
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      widget.selectedTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentTitle = 'Account Settings';
          widget.currentPage =
              WillPopScope(onWillPop: onWillPop, child: AccountSettings());
          break;
        case 1:
          widget.currentTitle = 'BattleField';
          widget.currentPage = WillPopScope(
              onWillPop: onWillPopHome, child: BattleFieldScreen());
          break;
        case 2:
          widget.currentTitle = 'PlayGround';
          widget.currentPage =
              WillPopScope(onWillPop: onWillPop, child: PlayGround());
          break;
        case 3:
          widget.currentTitle = 'LeaderBoard';
          widget.currentPage =
              WillPopScope(onWillPop: onWillPop, child: LeaderBoard());
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    PopupMenuButton _itemDown() => PopupMenuButton(
          padding: EdgeInsets.all(0),
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20))),
          tooltip: "Profile Options",
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'Value1',
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/Tabs', arguments: 4);
                  },
//                  radius: ,
                  child: Text(
                    'Profile Setting',
                    textAlign: TextAlign.center,
                  )),
            ),
            PopupMenuItem<String>(
              value: 'Value2',
              child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Help',
                    textAlign: TextAlign.center,
                  )),
            ),
            PopupMenuItem<String>(
              value: 'Value3',
              child: GestureDetector(
                  onTap: () async {
                    await AuthService().logOutUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.center,
                  )),
            )
          ],
          child: CircleAvatar(
            backgroundImage: user.image != ''
                ? NetworkImage(
                    user.image,
                  )
                : AssetImage('img/user2.jpg'),
          ),
        );
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.currentTab == 1 || widget.currentTab == 2
            ? AppBar(
                title: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.currentTitle,
                          style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.w800,
                              fontFamily: "karla",
                              fontSize: 26),
                        ),
                        widget.currentTab == 1
                            ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(UiIcons.money),
                                      Text(
                                        "  ${Provider.of<User>(context, listen: true).inWalletCash.toString()}",
                                        style: TextStyle(fontFamily: "karla"),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      decoration: ShapeDecoration(
                                          shape: StadiumBorder(),
                                          color: Colors.pink),
                                      child: Text(
                                        "Add Money",
                                        style: TextStyle(fontFamily: "karla"),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Icon(FontAwesomeIcons.coins),
                                  Text(
                                    "  ${Provider.of<User>(context, listen: true).points.toString()}",
                                    style: TextStyle(fontFamily: "karla"),
                                  ),
                                ],
                              ),
                      ]),
                ),
                backgroundColor: Colors.amber,
                centerTitle: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(20))),
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  labelStyle: TextStyle(fontSize: 20, fontFamily: "karla"),
                  labelColor: Theme.of(context).accentColor,
//            indicatorColor: Colors.transparent,
                  unselectedLabelColor: Colors.black38,
                  tabs: [
                    Tab(
                      child: Text("50"),
                    ),
                    Tab(
                      child: Text("100"),
                    ),
                    Tab(
                      child: Text("500"),
                    ),
                    Tab(
                      child: Text("1000"),
                    )
                  ],
                ),
              )
            : AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    widget.currentTitle,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Theme.of(context).accentColor,
                        fontWeight: FontWeight.w800,
                        fontFamily: "karla",
                        fontSize: 26),
                  ),
                ),
                actions: <Widget>[
                  Container(
                    width: 30,
                    height: 30,
                    margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 10),
                    child: _itemDown(),
                  ),
                ],
              ),
        body: widget.currentPage,
        bottomNavigationBar: FlipBoxBarPlus(
          animationDuration: Duration(seconds: 1),
//          navBarHeight: MediaQuery.of(context).size.height * 0.1,
          navBarWidth: MediaQuery.of(context).size.width * 0.8,
          onIndexChanged: (int i) {
            this._selectTab(i);
          },
          selectedIndex: widget.currentTab,
          items: [
            FlipBarItem(
                icon: Icon(UiIcons.home),
                text: Text(
                  "Account",
                  style: TextStyle(
                    fontFamily: "karla",
                  ),
                ),
                frontColor: Colors.cyan,
                backColor: Colors.cyanAccent),
            FlipBarItem(
                icon: Icon(FontAwesomeIcons.biohazard),
                text: Text(
                  "BattleField",
                  style: TextStyle(
                    fontFamily: "karla",
                  ),
                ),
                frontColor: Colors.orange,
                backColor: Colors.orangeAccent),
            FlipBarItem(
                icon: Icon(FontAwesomeIcons.footballBall),
                text: Text(
                  "PlayGround",
                  style: TextStyle(
                    fontFamily: "karla",
                  ),
                ),
                frontColor: Colors.purple,
                backColor: Colors.purpleAccent),
            FlipBarItem(
                icon: Icon(Icons.format_list_numbered),
                text: Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontFamily: "karla",
                  ),
                ),
                frontColor: Colors.pink,
                backColor: Colors.pinkAccent),
          ],
        ),
      ),
    );
  }
}
