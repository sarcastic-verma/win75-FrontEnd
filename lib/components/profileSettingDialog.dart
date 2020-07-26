// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:win75/controllers/user_controllers.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/constants.dart';

class ProfileSettingsDialog extends StatefulWidget {
  final VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  bool loaderScreen = false;
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context, listen: true);
    return FlatButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            GlobalKey<FormState> _profileSettingsFormKey =
                new GlobalKey<FormState>();
            final TextEditingController usernameController =
                TextEditingController();
            final TextEditingController mobileController =
                TextEditingController();
            File _selectedFile;
            bool _inProcess = false;

            return StatefulBuilder(
              builder: (context, setState) {
                return loaderScreen
                    ? SimpleDialog(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        titlePadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(UiIcons.user_1),
                            SizedBox(width: 10),
                            Text(
                              'Profile Settings',
                              style: Theme.of(context).textTheme.bodyText1,
                            )
                          ],
                        ),
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Center(
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  margin: EdgeInsets.only(
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(300),
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              color: Colors.black
                                                  .withOpacity(0.784),
                                              height: 150,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            25.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            25.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Center(
                                                      child: Text(
                                                        "Choose from",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          onPressed: () async {
                                                            // getImage(ImageSource.camera);
                                                            setState(() {
                                                              _inProcess = true;
                                                              widget
                                                                  .onChanged();
                                                            });
                                                            print(
                                                                'selectedFile: $_selectedFile');
                                                            File image =
                                                                await ImagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.camera);
                                                            if (image != null) {
                                                              File cropped = await ImageCropper
                                                                  .cropImage(
                                                                      sourcePath:
                                                                          image
                                                                              .path,
                                                                      aspectRatio: CropAspectRatio(
                                                                          ratioX:
                                                                              1,
                                                                          ratioY:
                                                                              1),
                                                                      compressQuality:
                                                                          100,
                                                                      maxWidth:
                                                                          700,
                                                                      maxHeight:
                                                                          700,
                                                                      compressFormat:
                                                                          ImageCompressFormat
                                                                              .jpg,
                                                                      androidUiSettings:
                                                                          AndroidUiSettings(
                                                                        toolbarColor:
                                                                            Colors.blue,
                                                                        toolbarTitle:
                                                                            "Win75 Cropper",
                                                                        statusBarColor:
                                                                            Colors.blue,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ));
                                                              print(
                                                                  'cropped: $cropped');
                                                              Navigator.pop(
                                                                  context);
                                                              print(
                                                                  'befire selectedFile: $_selectedFile');
                                                              setState(() {
                                                                _selectedFile =
                                                                    cropped;
                                                                print(
                                                                    'selectedFile: $_selectedFile');
                                                                _inProcess =
                                                                    false;
                                                                widget
                                                                    .onChanged();
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _inProcess =
                                                                    false;
                                                                widget
                                                                    .onChanged();
                                                              });
                                                            }
                                                          },
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .photo_camera,
                                                                size: 38.0,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                "Camera",
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .accentColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w300),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              horizontal: 10.0,
                                                            ),
                                                            child: Container(
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.15,
                                                              width: 1.0,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                            ),
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Icon(Icons.photo,
                                                                  size: 38.0),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text("Gallery",
                                                                  style: TextStyle(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .accentColor,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300)),
                                                            ],
                                                          ),
                                                          onPressed: () async {
                                                            // getImage(ImageSource.gallery);
                                                            setState(() {
                                                              _inProcess = true;
                                                              widget
                                                                  .onChanged();
                                                            });
                                                            print(
                                                                'selectedFile: $_selectedFile');
                                                            File image =
                                                                await ImagePicker
                                                                    .pickImage(
                                                                        source:
                                                                            ImageSource.gallery);
                                                            if (image != null) {
                                                              File cropped = await ImageCropper
                                                                  .cropImage(
                                                                      sourcePath:
                                                                          image
                                                                              .path,
                                                                      aspectRatio: CropAspectRatio(
                                                                          ratioX:
                                                                              1,
                                                                          ratioY:
                                                                              1),
                                                                      compressQuality:
                                                                          100,
                                                                      maxWidth:
                                                                          700,
                                                                      maxHeight:
                                                                          700,
                                                                      compressFormat:
                                                                          ImageCompressFormat
                                                                              .jpg,
                                                                      androidUiSettings:
                                                                          AndroidUiSettings(
                                                                        toolbarColor:
                                                                            Colors.blue,
                                                                        toolbarTitle:
                                                                            "Yehlo Cropper",
                                                                        statusBarColor:
                                                                            Colors.blue,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                      ));
                                                              print(
                                                                  'cropped: $cropped');
                                                              Navigator.pop(
                                                                  context);
                                                              print(
                                                                  'befire selectedFile: $_selectedFile');
                                                              setState(() {
                                                                _selectedFile =
                                                                    cropped;
                                                                print(
                                                                    'selectedFile: $_selectedFile');
                                                                _inProcess =
                                                                    false;
                                                                widget
                                                                    .onChanged();
                                                              });
                                                            } else {
                                                              setState(() {
                                                                _inProcess =
                                                                    false;
                                                                widget
                                                                    .onChanged();
                                                              });
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: _selectedFile != null
                                          ? FileImage(
                                              _selectedFile,
                                            )
                                          : ((user.image != ''
                                              ? NetworkImage(
                                                  user.image,
                                                )
                                              : AssetImage(
                                                  'assets/images/userDefault.jpeg'))),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                right: 63,
                                child: Icon(
                                  Icons.photo_camera,
                                ),
                              ),
                              (_inProcess)
                                  ? Container(
                                      color: Colors.white,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.95,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Center(),
                            ],
                          ),
                          Form(
                            key: _profileSettingsFormKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: usernameController,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.text,
                                  decoration: kTextFieldDecoration.copyWith(
                                      labelText: "${user.username}",
                                      hintText: "New Username"),
                                  validator: (input) => input.trim().length == 0
                                      ? 'Enter a username'
                                      : null,
                                  onSaved: (input) async {},
                                ),
                                TextFormField(
                                  controller: mobileController,
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: kTextFieldDecoration.copyWith(
                                      hintText: "New Enter mobile",
                                      labelText: user.mobile),
                                  validator: (value) {
                                    if ((value.length != 10)) {
                                      return 'Please enter a valid mobile number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: <Widget>[
                              MaterialButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: isSaved ? Text("Done") : Text('Close'),
                              ),
                              MaterialButton(
                                onPressed: () async {
                                  if (_profileSettingsFormKey.currentState
                                      .validate()) {
                                    print("Reached submission");
                                    _profileSettingsFormKey.currentState.save();
                                    Navigator.pop(context);

                                    setState(() {
                                      loaderScreen = true;
                                      isSaved = true;
                                    });
                                    await UserController.editUser(
                                        image: _selectedFile,
                                        mobile: mobileController.text,
                                        email: user.email,
                                        username: usernameController.text);
                                    Provider.of<User>(context).updateUser(
                                        inWalletCash: user.inWalletCash,
                                        points: user.points,
                                        image: user.image,
                                        username: user.username,
                                        mobile: user.mobile);
                                    print("loaderScreen $loaderScreen");
                                    print(_profileSettingsFormKey);
                                    print("Reached submission");
                                    setState(() {
                                      mobileController.clear();
                                      usernameController.clear();
                                      loaderScreen = false;
                                      print("loaderScreen2nd $loaderScreen");
                                    });
                                  }
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor),
                                ),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.end,
                          ),
                          SizedBox(height: 10),
                        ],
                      )
                    : Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.78)),
                        child: Center(
                          child: SpinKitFadingCube(
                            color: Theme.of(context).accentColor,
                            size: 56.0,
                          ),
                        ),
                      );
              },
            );
          },
        );
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
