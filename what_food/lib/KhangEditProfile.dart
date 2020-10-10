import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Models/UserData.dart';

import 'KhangProfile.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentUserId;
  EditProfileScreen({Key key, this.currentUserId}) : super(key: key);

  @override
  _EditProfileScreen createState() => _EditProfileScreen();
}

class _EditProfileScreen extends State<EditProfileScreen> {
  String name = '', bio = '', email = '';
  TextEditingController _profileNameController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  Future<User> user;
  bool _profileNameValid = true;
  bool _bioValid = true;
  //bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    user = AuthService.profile_Author();
  }

  _saved() {
    setState(() {
      _profileNameController.text.trim().length <3 || _profileNameController.text.isEmpty
        ? _profileNameValid = false
        : _profileNameValid = true;   
      _bioController.text.trim().length > 100 || _bioController.text.isEmpty
        ? _bioValid = false
        : _bioValid = true;
    });
    if (_profileNameValid && _bioValid) {
    AuthService.upDateProfileUser(name, bio, 'khang123@gmail.com', '');
  
    Navigator.pop(context, MaterialPageRoute(
      builder: (context) {
        return ProfileScreen();
    }));
    }  
  }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<User>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TextField(
                            controller: _profileNameController,
                            decoration: InputDecoration(
                                hintText: 'Enter Name',
                                errorText: _profileNameValid
                                    ? null
                                    : 'Name is too short'
                              ),
                          onChanged: (value) => {
                        },
                      ),
                      TextField(
                            controller: _bioController,
                            decoration: InputDecoration(
                                hintText: 'Enter Bio',
                                errorText: _bioValid
                                    ? null
                                    : 'Bio is too long'
                              ),
                          onChanged: (value) => {
                            if (value.isNotEmpty) {
                              bio = value,
                          }
                          else{
                            setState(() {
                              _bioController.text.trim().length > 100 || _bioController.text.isEmpty
                                ? _bioValid = false
                                : _bioValid = true;                         
                              }
                            )
                          }
                        },
                      ),
                          RaisedButton(
                            child: Text('Update Data'),
                            onPressed: () => _saved(),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                  }
                  return CircularProgressIndicator();
                })));
  }
}
