import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:what_food/Models/UserModel.dart';


import 'Screens/Login/login_screen.dart';
import 'Services/AuthService.dart';

class ProfileFirst extends StatefulWidget {
  final String currentUserId;
  final String userId;

  ProfileFirst({this.currentUserId, this.userId});

  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = AuthService.profile_Author();
    //_setupProfileUser();
  }

   _navigatorToEditScreen() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return null;
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



  Widget build(BuildContext context) {
    return Scaffold(
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
          future: futureUser,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                  body: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.grey,
                    backgroundImage: snapshot.data.avatar.isEmpty
                        ? AssetImage('assets/Avatar_default.jpg')
                        : CachedNetworkImageProvider(snapshot.data.avatar),
                  ),
                  DraggableScrollableSheet(
                    minChildSize: 0.1,
                    initialChildSize: 0.22,
                    builder: (context, scrollController) {
                      return SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              //for user profile header
                              Container(
                                padding:
                                    EdgeInsets.only(left: 32, right: 32, top: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircleAvatar(
                                        radius: 50.0,
                                        backgroundColor: Colors.grey,
                                        backgroundImage:
                                            snapshot.data.avatar.isEmpty
                                                ? AssetImage(
                                                    'assets/Avatar_default.jpg')
                                                : CachedNetworkImageProvider(
                                                    snapshot.data.avatar),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            snapshot.data.name,
                                            style: TextStyle(
                                                color: Colors.grey[800],
                                                fontFamily: "Roboto",
                                                fontSize: 36,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            snapshot.data.bio,
                                            style: TextStyle(
                                                color: Colors.grey[500],
                                                fontFamily: "Roboto",
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      Icons.sms,
                                      color: Colors.blue,
                                      size: 40,
                                    ),
                                    
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      color: Colors.blue,
                                      iconSize: 40,
                                      onPressed: () =>_navigatorToEditScreen(),
                                      )
                                  ],
                                ),
                              ),

                              //performace bar

                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: EdgeInsets.all(32),
                                color: Colors.blue,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.check_box,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "234",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Roboto",
                                                  fontSize: 24),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Follower",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.favorite,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "400",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Roboto",
                                                  fontSize: 24),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Following",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.star,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "5",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Roboto",
                                                  fontSize: 24),
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Ratings",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Roboto",
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      )
    );
  }
}
