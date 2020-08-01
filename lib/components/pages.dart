import 'package:flip_box_bar_plus/flip_box_bar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:win75/models/User.dart';
import 'package:win75/screens/AccountSettings.dart';
import 'package:win75/screens/FAQ.dart';
import 'package:win75/screens/authentication.dart';
import 'package:win75/screens/battlefield.dart';
import 'package:win75/screens/leaderboard.dart';
import 'package:win75/screens/playground.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';
import 'package:win75/utilities/constants.dart';

// ignore: must_be_immutable
class Pages extends StatefulWidget {
  static const id = '/pages';

  int currentTab = 1;
  int selectedTab = 1;
  String currentTitle = 'BattleField';
  Widget currentPage = BattleFieldScreen();

  Pages({
    Key key,
    @required this.currentTab,
  });

  @override
  _PagesState createState() {
    return _PagesState();
  }
}

class _PagesState extends State<Pages> {
  final AuthService authService = AuthService();
  final _walletFormKey = GlobalKey<FormState>();
  final TextEditingController addAmountController = TextEditingController();
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
          widget.currentTitle = 'Account';
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
    User user = Provider.of<User>(context, listen: true);
    print(user.inWalletCash);
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
                    Navigator.of(context)
                        .popAndPushNamed(Pages.id, arguments: 0);
                  },
//                  radius: ,
                  child: Text(
                    'Account',
                    textAlign: TextAlign.center,
                  )),
            ),
            PopupMenuItem<String>(
              value: 'Value2',
              child: GestureDetector(
                  onTap: () {
                    Navigator.popAndPushNamed(context, FAQ.id);
                  },
                  child: Text(
                    "FAQs and support",
                    textAlign: TextAlign.center,
                  )),
            ),
            PopupMenuItem<String>(
              value: 'Value3',
              child: GestureDetector(
                  onTap: () async {
                    await AuthService().logOutUser();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AuthScreen.id, (route) => false);
                  },
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.center,
                  )),
            )
          ],
          child: CircleAvatar(
            backgroundImage:
//            user.image != null
//                ? NetworkImage(
//                    user.image.replaceAll('localhost', '10.0.2.2'),
//                  )
//                :
                AssetImage('assets/images/userDefault.jpeg'),
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
                                    onTap: () {
                                      Alert(
                                              context: context,
                                              buttons: [
                                                DialogButton(
                                                  child: Text(
                                                    "Proceed",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () async {
                                                    if (_walletFormKey
                                                        .currentState
                                                        .validate()) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  color: Color.fromRGBO(
                                                      0, 179, 134, 1.0),
                                                  radius: BorderRadius.circular(
                                                      0.0),
                                                ),
                                              ],
                                              title: "Enter amount to add",
                                              content: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 6,
                                                            bottom: 20.0),
                                                    child: Form(
                                                      key: _walletFormKey,
                                                      child: TextFormField(
                                                          controller:
                                                              addAmountController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .numberWithOptions(),
                                                          decoration: kTextFieldDecoration
                                                              .copyWith(
                                                                  prefixIcon:
                                                                      Icon(UiIcons
                                                                          .money),
                                                                  hintText:
                                                                      "Enter Amount",
                                                                  labelText:
                                                                      "Amount"),
                                                          validator: (value) {
                                                            if (value.isEmpty) {
                                                              return 'Please enter amount';
                                                            }
                                                            return null;
                                                          }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              style: kAlertStyle)
                                          .show();
                                    },
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
                actions: widget.currentTab == 3
                    ? <Widget>[
                        Container(
                          width: 30,
                          height: 30,
                          margin: EdgeInsets.only(
                              top: 12.5, bottom: 12.5, right: 10),
                          child: _itemDown(),
                        ),
                      ]
                    : null,
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
