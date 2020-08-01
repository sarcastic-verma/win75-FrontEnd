import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:win75/components/QnA.dart';

class FAQ extends StatelessWidget {
  static const id = '/fAq';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FAQs and Support"),
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          children: [
            Text(
              "FAQs",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            QnA(
              answer: "Try restarting the app, if that dosen't help. Call us!!",
              question:
                  "Even after successful payments I don't see the update wallet amount. Or even after updating wallet amount automatically refreshes to old amount",
            ),
            QnA(
              answer: "Try restarting the app, if that dosen't help. Call us!!",
              question:
                  "Profile name not updated instantly, or games/transaction dosen't show in history",
            ),
            QnA(
              answer: "Puzza",
              question: "This is a Dummy question with pizza at it's heart",
            ),
            QnA(
              answer: "Puzza",
              question: "This is a Dummy question with pizza at it's heart",
            ),
            QnA(
              answer: "Question",
              question: "Dummy",
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Support",
              style: Theme.of(context).textTheme.headline2,
              textAlign: TextAlign.center,
            ),
            Text(
              "\nIncase of no answer\nYou shall receive a callback within 5hrs",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.black38),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: RaisedButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            color: Colors.black.withOpacity(0.537),
                            height: 240,
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(25.0),
                                    topRight: const Radius.circular(25.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        "Select",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        await launch("tel://9897699041");
                                      },
                                      title: Text(
                                        "9897699041",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      leading: Icon(
                                        FontAwesomeIcons.phoneAlt,
                                        size: 20,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "9958869248",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () async {
                                        await launch("tel://9958869248");
                                      },
                                      leading: Icon(
                                        FontAwesomeIcons.phoneAlt,
                                        size: 20,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(
                                        "9953798220",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                                fontWeight: FontWeight.w600),
                                      ),
                                      onTap: () async {
                                        await launch("tel://9953798220");
                                      },
                                      leading: Icon(
                                        FontAwesomeIcons.phoneAlt,
                                        size: 20,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                  ],
                                )),
                          );
                        });
                  },
                  color: Theme.of(context).accentColor.withOpacity(0.9),
                  child: Text(
                    "Contact Us",
                    style: Theme.of(context).textTheme.headline4,
                  )),
            ),
          ],
        ));
  }
}
