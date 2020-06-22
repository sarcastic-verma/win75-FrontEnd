// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:win75/models/User.dart';
import 'package:win75/utilities/UiIcons.dart';
import 'package:win75/utilities/auth.dart';

class ProfileSettingsDialog extends StatefulWidget {
  VoidCallback onChanged;

  ProfileSettingsDialog({Key key, this.user, this.onChanged}) : super(key: key);

  @override
  _ProfileSettingsDialogState createState() => _ProfileSettingsDialogState();
}

class _ProfileSettingsDialogState extends State<ProfileSettingsDialog> {
  bool loaderScreen = false;
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    void updateProvider(String url) {
//      Provider.of<User>(context, listen: false).updateUser(
//        username: user.username,
//        image: url,
//        uid: user.uid,
//        email: user.email,
//      );
    }

    InputDecoration getInputDecoration({String hintText, String labelText}) {
      return new InputDecoration(
        hintText: hintText,
        labelText: labelText,
        hintStyle: Theme.of(context).textTheme.body1.merge(
              TextStyle(color: Theme.of(context).focusColor),
            ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).hintColor.withOpacity(0.2))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).hintColor)),
        hasFloatingPlaceholder: true,
        labelStyle: Theme.of(context).textTheme.body1.merge(
              TextStyle(color: Theme.of(context).hintColor),
            ),
      );
    }

    return FlatButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            // int count = 1;

            AuthService service = new AuthService();
            // void initState() async {
            //   User result = await service.getUserFromSharedPreferences();

            //   String name = result.username;
            //   print('name: $name');
            // }
            GlobalKey<FormState> _profileSettingsFormKey =
                new GlobalKey<FormState>();
            File _selectedFile;
            bool _inProcess = false;

            void getImage(ImageSource source) async {
              setState(() {
                _inProcess = true;
                widget.onChanged();
              });
              print('selectedFile: $_selectedFile');
              File image = await ImagePicker.pickImage(source: source);
              if (image != null) {
                File cropped = await ImageCropper.cropImage(
                    sourcePath: image.path,
                    aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                    compressQuality: 100,
                    maxWidth: 700,
                    maxHeight: 700,
                    compressFormat: ImageCompressFormat.jpg,
                    androidUiSettings: AndroidUiSettings(
                      toolbarColor: Colors.blue,
                      toolbarTitle: "Yehlo Cropper",
                      statusBarColor: Colors.blue,
                      backgroundColor: Colors.white,
                    ));
                print('cropped: $cropped');
                Navigator.pop(context);
                print('befire selectedFile: $_selectedFile');
                setState(() {
                  _selectedFile = cropped;
                  print('selectedFile: $_selectedFile');
                  _inProcess = false;
                  widget.onChanged();
                });
              } else {
                setState(() {
                  _inProcess = false;
                  widget.onChanged();
                });
              }
            }

            void _submit() {
              if (_profileSettingsFormKey.currentState.validate()) {
                print("Reached submission");
                // setState(() {
                //   loaderScreen = false;
                // });
                _profileSettingsFormKey.currentState.save();
                // Navigator.pop(context);
              }
            }

            void cameraPress() {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.photo_camera),
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.photo),
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    );
                  });
            }

            // void change() {
            //   setState(() {
            //     count = 2;
            //   });
            // }

            print(service);

            Future uploadPic(BuildContext context) async {
              try {
                if (_selectedFile != null) {
                  String fileName = basename(user.uid);
                  //  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(fileName);
                  //  firebaseStorageRef.delete();
                  StorageReference newFirebaseStorageRef = FirebaseStorage
                      .instance
                      .ref()
                      .child("UserImages/$fileName");
                  StorageUploadTask uploadTask =
                      newFirebaseStorageRef.putFile(_selectedFile);
                  //  StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
                  var dowurl =
                      await (await uploadTask.onComplete).ref.getDownloadURL();
                  String url = dowurl.toString();
                  print('url: $url');
                  updateProvider(url);
                  print("image");
                  print(user.image);
                  service.updateUsernameImage(user.username, url, user.uid);

                  // String oldUser =
                  //     (await service.getUserFromSharedPreferences())
                  //         .username;
                  // print('oldName $oldUser');
                  service.storeUserInSharedPreferences(
                      username: user.username,
                      image: user.image,
                      uid: user.uid,
                      joinedOn: user.joinedOn,
                      email: user.email);
                }
                print('Profile Detail updated');
                // setState(() {
                //     // loaderScreen = false;
                //     // print("loaderScreen2nd $loaderScreen");
                //     print('Profile Detail updated');
                //     // _profileSettingsFormKey.currentState.save();
                //     // Navigator.of(context).pop();
                //   });
                // setState(() {
                //   // isSaved = true;
                //   print('Profile Detail updated');
                // });
              } catch (e) {
                print(e);
              }
            }
            // Widget getImageWidget() {
            //   return Image.file(
            //     (selectedFile != null
            //         ? selectedFile
            //         :),
            //     width: 50,
            //     height: 50,
            //     fit: BoxFit.cover,
            //   );
            // }

            // Widget getImageWidget() {
            //   if (_selectedFile != null) {
            //     return FileImage(
            //       _selectedFile,
            //       // width: 250,
            //       // height: 250,
            //       // fit: BoxFit.cover,
            //     );
            //   } else {
            //     return Image.asset(
            //       "img/user2.jpg",
            //       // width: 250,
            //       // height: 250,
            //       // fit: BoxFit.cover,
            //     );
            //   }
            // }

            return StatefulBuilder(
              builder: (context, setState) {
                return loaderScreen
                    ? Container(
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
                      )
                    : SimpleDialog(
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
                              style: Theme.of(context).textTheme.body2,
                            )
                          ],
                        ),
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              // (_selectedFile != null)
                              //     ? Image.file(
                              //         _selectedFile,
                              //         width: 250,
                              //         height: 250,
                              //         fit: BoxFit.cover,
                              //       )
                              //     : Image.asset(
                              //         "img/user2.jpg",
                              //         width: 250,
                              //         height: 250,
                              //         fit: BoxFit.cover,
                              //       ),
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
                                      // change();
                                      // setState(() {
                                      //   count = 2;
                                      // });
                                      // cameraPress();
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
                                              // width: 50,
                                              // height: 50,
                                              // fit: BoxFit.cover,
                                            )
                                          : ((user.image != ''
                                              ? NetworkImage(
                                                  user.image,
                                                )
                                              : AssetImage('img/user2.jpg'))),
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
                              // (getImageWidget()),
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
                                new TextFormField(
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                  keyboardType: TextInputType.text,
                                  decoration: getInputDecoration(
                                      hintText: 'Enter your Username',
                                      labelText: 'Username'),
                                  initialValue: user.username,
                                  validator: (input) => input.trim().length == 0
                                      ? 'Enter a username'
                                      : null,
                                  onSaved: (input) async {
//                                    Provider.of<User>(context, listen: false)
//                                        .updateUser(
//                                      username: input,
//                                      image: user.image,
//                                      date: user.date,
//                                      uid: user.uid,
//                                      phoneNumber: user.phoneNumber,
//                                      email: user.email,
//                                    );
                                    print("input_${input}");
                                    service.updateUsernameImage(
                                        input, user.image, user.uid);
                                    // String oldUser =
                                    //     (await service.getUserFromSharedPreferences())
                                    //         .username;
                                    // print('oldName $oldUser');
                                    service.storeUserInSharedPreferences(
                                        username: input,
                                        image: user.image,
                                        joinedOn: user.joinedOn,
                                        uid: user.uid,
                                        email: user.email);
                                    // String newUser =
                                    //     (await service.getUserFromSharedPreferences())
                                    //         .username;
                                    // print('newName $newUser');
                                  },
                                ),
                                new TextFormField(
                                  enabled: false,
                                  style: TextStyle(
                                      color: Theme.of(context).hintColor),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: getInputDecoration(
                                      hintText: '', labelText: 'Email Address'),
                                  initialValue: user.email,
                                  validator: (input) => null,
                                  // onSaved: (input) => widget.user.email = input,
                                ),
                                // FormField<String>(
                                //   builder: (FormFieldState<String> state) {
                                //     return DropdownButtonFormField<String>(
                                //       decoration: getInputDecoration(hintText: 'Female', labelText: 'Gender'),
                                //       hint: Text("Select Device"),
                                //       value: widget.user.gender,
                                //       onChanged: (input) {
                                //         setState(() {
                                //           widget.user.gender = input;
                                //           widget.onChanged();
                                //         });
                                //       },
                                //       onSaved: (input) => widget.user.gender = input,
                                //       items: [
                                //         new DropdownMenuItem(value: 'Male', child: Text('Male')),
                                //         new DropdownMenuItem(value: 'Female', child: Text('Female')),
                                //       ],
                                //     );
                                //   },
                                // ),
                                // FormField<String>(
                                //   builder: (FormFieldState<String> state) {
                                //     return DateTimeField(
                                //       decoration: getInputDecoration(hintText: '1996-12-31', labelText: 'Birth Date'),
                                //       format: new DateFormat('yyyy-MM-dd'),
                                //       initialValue: widget.user.dateOfBirth,
                                //       onShowPicker: (context, currentValue) {
                                //         return showDatePicker(
                                //             context: context,
                                //             firstDate: DateTime(1900),
                                //             initialDate: currentValue ?? DateTime.now(),
                                //             lastDate: DateTime(2100));
                                //       },
                                //       onSaved: (input) => setState(() {
                                //         widget.user.dateOfBirth = input;
                                //         widget.onChanged();
                                //       }),
                                //     );
                                //   },
                                // ),
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
                                  setState(() {
                                    loaderScreen = true;
                                    isSaved = true;
                                  });
                                  await uploadPic(context);
                                  print("loaderScreen $loaderScreen");

                                  //  _submit();
                                  // print(_profileSettingsFormKey.currentState.validate());
                                  print(_profileSettingsFormKey);
                                  print("Reached submission");
                                  // setState(() {
                                  //   loaderScreen = false;
                                  // });
                                  setState(() {
                                    loaderScreen = false;
                                    print("loaderScreen2nd $loaderScreen");
                                    // _profileSettingsFormKey.currentState.save();
                                    // Navigator.of(context).pop();
                                  });
                                  // if (_profileSettingsFormKey.currentState.validate()) {
                                  //   print("Reached submission");
                                  //   // setState(() {
                                  //   //   loaderScreen = false;
                                  //   // });
                                  // _profileSettingsFormKey.currentState.save();
                                  //   Navigator.pop(context);
                                  // }
                                  _submit();
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
                      );
              },
            );
          },
        );
      },
      child: Text(
        "Edit",
        style: Theme.of(context).textTheme.body1,
      ),
    );
  }
}
