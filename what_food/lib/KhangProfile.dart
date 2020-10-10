import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:what_food/Models/UserModel.dart';
import 'package:what_food/Screens/Login/login_screen.dart';
import 'package:what_food/Services/AuthService.dart';
import 'package:what_food/components/rounded_button.dart';

import 'KhangEditProfile.dart';



class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  Future<User> user;

  @override
  void initState() {
    super.initState();
    user = AuthService.profile_Author();
  }

   _navigatorToEditScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return EditProfileScreen();
        }
      )
    );
  }

  
  _logoutApp(){
    AuthService.logout_Author();
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return LoginScreen();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
           actions: <Widget>[
            IconButton(
              icon: Icon(Icons.exit_to_app), 
              onPressed: _logoutApp,
            )
          ],
        ),
        body: Center(
          child: FutureBuilder<User>(
            future: user,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("${snapshot.data.avatar}");
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(145.0, 20.0, 30.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundColor: Colors.grey,
                            backgroundImage: snapshot.data.avatar.isEmpty
                                ? AssetImage('assets/Avatar_default.jpg')
                                : CachedNetworkImageProvider(snapshot.data.avatar),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 140.0, vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data.name,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.0),
                        ],
                      ),
                    ),
                      Text(
                            snapshot.data.bio,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.0),
                       Container(
                            padding: EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                RoundedButton(
                                  text: "Edit Profile",
                                  press: _navigatorToEditScreen,
                                )
                              ],
                            ),
                          )
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

